import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:khola_chithi/widgets/message_field.dart';
import 'package:khola_chithi/x_old/auth_controller.dart';
import 'package:khola_chithi/x_old/post_model.dart';
import 'package:khola_chithi/x_old/firestore.dart';
import 'package:provider/provider.dart';
import 'package:khola_chithi/core/utils/helper_function.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FireStoreService fireStoreService = FireStoreService();
  AuthController authController = AuthController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime time = DateTime.now();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final authController = Provider.of<AuthController>(context, listen: false);
    authController.getLastPost();
    authController.fetchPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        if (authController.lastDoc != authController.lastPostByfinalDoc) {
          authController.fetchPosts();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        final timeGap = DateTime.now().difference(time);
        time = DateTime.now();
        if (timeGap.inSeconds < 2) {
          exit(0);
        }
      },
      child: Consumer<AuthController>(
        builder: (context, values, child) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('খো লা চি ঠি'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(
                onPressed: () {
                  values.logout();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          floatingActionButton: _floatingActionButton(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: values.posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == values.posts.length && values.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (index == values.posts.length &&
                      !values.isLoading) {
                    return const SizedBox();
                  }
                  DocumentSnapshot document = values.posts[index];
                  PostModel post = PostModel.fromJson(
                      document.data() as Map<String, dynamic>);
                  values.reactions[document.id] =
                      post.totalReactions ?? <String>[];
                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    "প্রাপক : ${(post.postTitle.isEmpty) ? "নাম উল্লেখ করেন নি!" : post.postTitle}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "তারিখ : ${formatTimestamp(post.createdAt)}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ExpandableText(
                            (post.postDescription.isEmpty)
                                ? "চিঠিটি খালি রেখেছেন !"
                                : post.postDescription,
                            expandText: 'আরো দেখুন',
                            collapseText: 'কম দেখুন',
                            maxLines: 10,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (values.reactions[document.id]!
                                    .contains(values.user!.uid)) {
                                  values.reactions[document.id]!
                                      .remove(values.user!.uid);
                                } else {
                                  values.reactions[document.id]!
                                      .add(values.user!.uid);
                                }

                                fireStoreService.updatePost(
                                  document.id,
                                  post.copyWith(
                                      totalReactions:
                                          values.reactions[document.id]),
                                );
                              },
                              icon: (values.isReacted(document.id))
                                  ? Icon(
                                      Icons.favorite,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                            ),

                            // Expanded(child: child)
                            Text(
                              "${post.totalReactions!.length} জন পড়েছেন",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                            // Text(
                            //   "এডিট : ${values.formatTimestamp(post.updatedAt)}",
                            //   style: const TextStyle(
                            //     fontSize: 12,
                            //   ),
                            // ),
                            Visibility(
                              visible: values.user!.uid == post.uid,
                              child: IconButton(
                                onPressed: () {
                                  _showDialogWindow(
                                    context,
                                    post,
                                    document.id,
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ),

                            Visibility(
                              visible: values.user!.uid == post.uid,
                              child: IconButton(
                                onPressed: () {
                                  authController.deletPost(document.id);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogWindow(BuildContext context, PostModel post, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        titleController.text = post.postTitle;
        descriptionController.text = post.postDescription;
        return AlertDialog(
          title: const Text('আপনার চিঠি পরিবর্তন করুন'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MessageField(
                  hintText: "কাকে চিঠি পাঠাবেন?", controller: titleController),
              const SizedBox(height: 10),
              MessageField(
                  hintText: "আপনার চিঠিটি লিখুন",
                  controller: descriptionController,
                  expandable: true),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final editedPost = post.copyWith(
                  postTitle: titleController.text,
                  postDescription: descriptionController.text,
                  updatedAt: Timestamp.now(),
                );
                fireStoreService.updatePost(id, editedPost);
                Navigator.pop(context);
                titleController.clear();
                descriptionController.clear();
                //even it pop the dialog, the text field filed will be cleared
              },
              child: Text(
                "পরির্তিত চিঠি পোস্ট করুন",
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('এখানে আপনার চিঠি লিখুন'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MessageField(
                    hintText: "কাকে চিঠি পাঠাবেন?",
                    controller: titleController,
                  ),
                  const SizedBox(height: 10),
                  MessageField(
                    hintText: "আপনার চিঠিটি লিখুন",
                    controller: descriptionController,
                    expandable: true,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    final newPost = PostModel(
                      postTitle: titleController.text,
                      postDescription: descriptionController.text,
                      createdAt: Timestamp.now(),
                      updatedAt: Timestamp.now(),
                      uid: authController.user!.uid,
                    );
                    fireStoreService.addPost(newPost);
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();
                  },
                  child: Text(
                    "চিঠি পোস্ট করুন",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
