// lib/features/post/domain/usecases/add_post.dart
import 'package:khola_chithi/features/post/domain/entities/post.dart';
import 'package:khola_chithi/features/post/domain/repositories/post_repository.dart';

class AddPost {
  final PostRepository repository;

  AddPost(this.repository);

  Future<void> call(Post post) async {
    return repository.addPost(post);
  }
}
