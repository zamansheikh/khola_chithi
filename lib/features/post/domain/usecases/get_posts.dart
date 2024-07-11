// lib/features/post/domain/usecases/get_posts.dart
import 'package:khola_chithi/features/post/domain/entities/post.dart';
import 'package:khola_chithi/features/post/domain/repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<List<Post>> call() async {
    return repository.getPosts();
  }
}