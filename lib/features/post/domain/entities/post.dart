// lib/features/post/domain/entities/post.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String toTheUser;
  final String message;
  final Timestamp createdAt;
  final Timestamp? editedAt;
  final List<String> readBy;

  Post({
    required this.id,
    required this.userId,
    required this.toTheUser,
    required this.message,
    required this.createdAt,
    this.editedAt,
    required this.readBy,
  });
}
