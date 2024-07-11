// lib/features/post/domain/usecases/edit_post.dart
import 'package:khola_chithi/features/post/domain/entities/post.dart';
import 'package:khola_chithi/features/post/domain/repositories/post_repository.dart';

class EditPost {
  final PostRepository repository;

  EditPost(this.repository);

  Future<void> call(Post post) async {
    return repository.editPost(post);
  }
}