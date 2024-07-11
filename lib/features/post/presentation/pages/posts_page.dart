// lib/features/post/presentation/pages/posts_page.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:khola_chithi/core/utils/helper_function.dart';
import 'package:khola_chithi/features/auth/presentation/providers/app_auth_provider.dart';
import 'package:khola_chithi/widgets/message_field.dart';
import 'package:provider/provider.dart';
import 'package:khola_chithi/features/post/domain/entities/post.dart';
import 'package:khola_chithi/features/post/presentation/providers/post_provider.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _messageController = TextEditingController();

  final _whomController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  DateTime time = DateTime.now();

  @override
  void initState() {
    super.initState();

    // final authController = Provider.of<AuthController>(context, listen: false);
    // authController.getLastPost();
    // authController.fetchPosts();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //       _scrollController.position.maxScrollExtent) {
    //     if (authController.lastDoc != authController.lastPostByfinalDoc) {
    //       authController.fetchPosts();
    //     }
    //   }
    // });
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
      child: Consumer<PostProvider>(builder: (context, value, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('খো লা চি ঠি'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AppAuthProvider>().signOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          floatingActionButton: _floatingAction(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: value.posts.length,
                itemBuilder: (context, index) {
                  final post = value.posts[index];
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
                                    "প্রাপক : ${(post.toTheUser.isEmpty) ? "নাম উল্লেখ করেন নি!" : post.toTheUser}",
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
                            (post.message.isEmpty)
                                ? "চিঠিটি খালি রেখেছেন !"
                                : post.message,
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
                              onPressed: () {},
                              icon: (true)
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
                              "${post.readBy.length} জন পড়েছেন",
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
                              visible: true,
                              child: IconButton(
                                onPressed: () {
                                  _showDialogWindow(
                                    context,
                                    post,
                                    "User ID passesd",
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ),

                            Visibility(
                              visible: true,
                              child: IconButton(
                                onPressed: () {
                                  value.deletePost("postID");
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
        );
      }),
    );
  }

  Widget _floatingAction(BuildContext context) => FloatingActionButton(
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
                      controller: _whomController,
                    ),
                    const SizedBox(height: 10),
                    MessageField(
                      hintText: "আপনার চিঠিটি লিখুন",
                      controller: _messageController,
                      expandable: true,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Post post = Post(
                        id: context.read<AppAuthProvider>().user!.id,
                        userId: context.read<AppAuthProvider>().user!.id,
                        toTheUser: _whomController.text,
                        message: _messageController.text,
                        createdAt: Timestamp.now(),
                        readBy: [],
                      );
                      context.read<PostProvider>().addPost(post);
                      Navigator.of(context).pop();
                      _whomController.clear();
                      _messageController.clear();
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

  void _showDialogWindow(BuildContext context, Post post, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _whomController.text = post.toTheUser;
        _messageController.text = post.message;
        return AlertDialog(
          title: const Text('আপনার চিঠি পরিবর্তন করুন'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MessageField(
                  hintText: "কাকে চিঠি পাঠাবেন?", controller: _whomController),
              const SizedBox(height: 10),
              MessageField(
                  hintText: "আপনার চিঠিটি লিখুন",
                  controller: _messageController,
                  expandable: true),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {},
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
}
