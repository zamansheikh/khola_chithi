// lib/features/auth/domain/usecases/sign_out.dart
import 'package:khola_chithi/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<void> call() async {
    await repository.signOut();
  }
}
