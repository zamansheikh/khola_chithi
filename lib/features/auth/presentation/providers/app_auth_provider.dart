// lib/features/auth/presentation/providers/app_auth_provider.dart
import 'package:flutter/material.dart';
import 'package:khola_chithi/features/auth/domain/entities/user.dart';
import 'package:khola_chithi/features/auth/domain/usecases/check_auth_status.dart';
import 'package:khola_chithi/features/auth/domain/usecases/sign_in.dart';
import 'package:khola_chithi/features/auth/domain/usecases/sign_out.dart';
import 'package:khola_chithi/features/auth/domain/usecases/sign_up.dart';

class AppAuthProvider with ChangeNotifier {
  final SignIn signInUseCase;
  final SignOut signOutUseCase;
  final CheckAuthStatus checkAuthStatusUseCase;
  final SignUp signUpUseCase;

  User? _user;
  User? get user => _user;
  bool isLoggedIn = false;
  bool isLoading = false;

  AppAuthProvider({
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.checkAuthStatusUseCase,
    required this.signUpUseCase,
  });

  void signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();
    _user = await signInUseCase(email, password);
    isLoading = false;
    notifyListeners();
  }

  void signUp(String email, String password, String userName) async {
    isLoading = true;
    notifyListeners();
    _user = await signUpUseCase(email, password, userName);
    isLoggedIn = _user != null;
    isLoading = false;

    notifyListeners();
  }

  void signOut() async {
    await signOutUseCase();
    _user = null;
    notifyListeners();
  }

  void checkAuthStatus() async {
    _user = await checkAuthStatusUseCase();
    isLoggedIn = _user != null;
    notifyListeners();
  }
}
