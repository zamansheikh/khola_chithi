// lib/features/auth/domain/usecases/sign_in.dart
import 'package:khola_chithi/features/auth/domain/entities/user.dart';
import 'package:khola_chithi/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatus {
  final AuthRepository repository;

  CheckAuthStatus(this.repository);

  Future<User?> call() {
    return repository.checkAuthStatus();
  }
}
