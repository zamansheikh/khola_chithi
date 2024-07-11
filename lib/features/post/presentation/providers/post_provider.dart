// lib/features/post/presentation/providers/post_provider.dart
import 'package:flutter/material.dart';
import 'package:khola_chithi/features/post/domain/entities/post.dart';
import 'package:khola_chithi/features/post/domain/usecases/add_post.dart';
import 'package:khola_chithi/features/post/domain/usecases/get_posts.dart';
import 'package:khola_chithi/features/post/domain/usecases/edit_post.dart';
import 'package:khola_chithi/features/post/domain/usecases/delete_post.dart';
import 'package:khola_chithi/features/post/domain/usecases/react_to_post.dart';

class PostProvider with ChangeNotifier {
  final AddPost addPostUseCase;
  final GetPosts getPostsUseCase;
  final EditPost editPostUseCase;
  final DeletePost deletePostUseCase;
  final ReactToPost reactToPostUseCase;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  PostProvider({
    required this.addPostUseCase,
    required this.getPostsUseCase,
    required this.editPostUseCase,
    required this.deletePostUseCase,
    required this.reactToPostUseCase,
  });

  Future<void> addPost(Post post) async {
    await addPostUseCase(post);
    _posts.add(post);
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    _posts = await getPostsUseCase();
    notifyListeners();
  }

  Future<void> editPost(Post post) async {
    await editPostUseCase(post);
    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index] = post;
      notifyListeners();
    }
  }

  Future<void> deletePost(String postId) async {
    await deletePostUseCase(postId);
    _posts.removeWhere((p) => p.id == postId);
    notifyListeners();
  }

  Future<void> reactToPost(String postId, String userId) async {
    await reactToPostUseCase(postId, userId);
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _posts[index];
      if (!post.readBy.contains(userId)) {
        post.readBy.add(userId);
        _posts[index] = post;
        notifyListeners();
      } else {
        post.readBy.remove(userId);
        _posts[index] = post;
        notifyListeners();
      }
    }
  }
}
