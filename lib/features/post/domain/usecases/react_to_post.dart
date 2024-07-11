// lib/features/post/domain/usecases/react_to_post.dart
import 'package:khola_chithi/features/post/domain/repositories/post_repository.dart';

class ReactToPost {
  final PostRepository repository;

  ReactToPost(this.repository);

  Future<void> call(String postId, String userId) async {
    return repository.reactToPost(postId, userId);
  }
}