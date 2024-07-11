// lib/features/post/domain/repositories/post_repository.dart
import 'package:khola_chithi/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<void> addPost(Post post);
  Future<List<Post>> getPosts();
  Future<void> editPost(Post post);
  Future<void> deletePost(String postId);
  Future<void> reactToPost(String postId, String userId);
}
