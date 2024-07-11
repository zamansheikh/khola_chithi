// lib/features/post/data/repositories/post_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khola_chithi/features/post/domain/entities/post.dart';
import 'package:khola_chithi/features/post/domain/repositories/post_repository.dart';
import 'package:khola_chithi/features/post/data/models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final FirebaseFirestore firestore;

  PostRepositoryImpl({required this.firestore});

  @override
  Future<void> addPost(Post post) async {
    final postModel = PostModel(
      id: post.id,
      userId: post.userId,
      toTheUser: post.toTheUser,
      message: post.message,
      createdAt: post.createdAt,
      editedAt: post.editedAt,
      readBy: post.readBy,
    );

    await firestore.collection('posts').add(postModel.toMap());
  }

  @override
  Future<List<Post>> getPosts() async {
    final querySnapshot = await firestore.collection('posts').get();
    return querySnapshot.docs
        .map((doc) => PostModel.fromFirebase(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> editPost(Post post) async {
    final postModel = PostModel(
      id: post.id,
      userId: post.userId,
      toTheUser: post.toTheUser,
      message: post.message,
      createdAt: post.createdAt,
      editedAt: post.editedAt,
      readBy: post.readBy,
    );

    await firestore.collection('posts').doc(post.id).update(postModel.toMap());
  }

  @override
  Future<void> deletePost(String postId) async {
    await firestore.collection('posts').doc(postId).delete();
  }

  @override
  Future<void> reactToPost(String postId, String userId) async {
    final postRef = firestore.collection('posts').doc(postId);
    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(postRef);
      if (snapshot.exists) {
        final postModel = PostModel.fromFirebase(snapshot.data() as Map<String, dynamic>, snapshot.id);
        if (!postModel.readBy.contains(userId)) {
          postModel.readBy.add(userId);
          transaction.update(postRef, {'readBy': postModel.readBy});
        }
      }
    });
  }
}
