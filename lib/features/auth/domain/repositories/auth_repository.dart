// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:khola_chithi/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Future<User?> checkAuthStatus();
  Future<User?> signUp(String email, String password, String userName);
}
