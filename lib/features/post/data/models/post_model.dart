// lib/features/post/data/models/post_model.dart
import 'package:khola_chithi/features/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.userId,
    required super.toTheUser,
    required super.message,
    required super.createdAt,
    super.editedAt,
    required super.readBy,
  });

  factory PostModel.fromFirebase(Map<String, dynamic> data) {
    return PostModel(
      id: "postId",
      userId: data['userId'],
      toTheUser: data['toTheUser'],
      message: data['message'],
      createdAt: (data['createdAt'] ),
      editedAt: data['editedAt'] != null
          ? (data['editedAt'] )
          : null,
      readBy: List<String>.from(data['readBy']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': id,
      'userId': userId,
      'toTheUser': toTheUser,
      'message': message,
      'createdAt': createdAt,
      'editedAt': editedAt,
      'readBy': readBy,
    };
  }
}
