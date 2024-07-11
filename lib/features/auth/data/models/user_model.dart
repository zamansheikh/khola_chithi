// lib/features/auth/data/models/user_model.dart
import 'package:khola_chithi/features/auth/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class UserModel extends User {
  UserModel({required super.id, required super.email});

  factory UserModel.fromFirebase(firebase.User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
    );
  }
}
