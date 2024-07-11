import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String postTitle;
  String postDescription;
  Timestamp createdAt;
  Timestamp updatedAt;
  List<String>? totalReactions;
  String uid;
  PostModel({
    required this.postTitle,
    required this.postDescription,
    required this.createdAt,
    required this.updatedAt,
    this.totalReactions = const <String>[],
    required this.uid,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : postTitle = json['postTitle'],
        postDescription = json['postDescription'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        totalReactions = (json['totalReactions'] as List<dynamic>?)
            ?.map((item) => item as String)
            .toList() ?? <String>[],
            uid = json['uid'];

  PostModel copyWith({
    String? postTitle,
    String? postDescription,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    List<String>? totalReactions,
    String? uid,
  }) {
    return PostModel(
      postTitle: postTitle ?? this.postTitle,
      postDescription: postDescription ?? this.postDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalReactions: totalReactions ?? this.totalReactions,
      uid: uid?? this.uid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postTitle': postTitle,
      'postDescription': postDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'totalReactions': totalReactions,
      'uid': uid,
    };
  }
}
