// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:khola_chithi/features/auth/domain/entities/user.dart';
import 'package:khola_chithi/features/auth/domain/repositories/auth_repository.dart';
import 'package:khola_chithi/features/auth/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase.FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Future<User?> signIn(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserModel.fromFirebase(result.user!);
    } catch (e) {
      // print(e.toString());
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return UserModel.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<User?> checkAuthStatus() async {
    if (firebaseAuth.currentUser != null) {
      return UserModel.fromFirebase(firebaseAuth.currentUser!);
    } else {
      return null;
    }
  }
}
