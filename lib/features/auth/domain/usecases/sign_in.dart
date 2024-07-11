// lib/features/auth/domain/usecases/sign_in.dart
import 'package:khola_chithi/features/auth/domain/entities/user.dart';
import 'package:khola_chithi/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<User?> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
