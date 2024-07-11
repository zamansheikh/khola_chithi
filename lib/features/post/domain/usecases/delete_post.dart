// lib/features/post/domain/usecases/delete_post.dart
import 'package:khola_chithi/features/post/domain/repositories/post_repository.dart';

class DeletePost {
  final PostRepository repository;

  DeletePost(this.repository);

  Future<void> call(String postId) async {
    return repository.deletePost(postId);
  }
}