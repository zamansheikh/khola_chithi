import 'package:khola_chithi/features/auth/domain/repositories/auth_repository.dart';

class SignUp{
  final AuthRepository repository;
  SignUp(this.repository);
  Future<void> call(String email, String password, String userName) async {
    await repository.signUp(email, password, userName);
  }
  
}