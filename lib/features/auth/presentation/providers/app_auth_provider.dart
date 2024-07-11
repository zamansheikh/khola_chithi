// lib/features/auth/presentation/providers/app_auth_provider.dart
import 'package:flutter/material.dart';
import 'package:khola_chithi/features/auth/domain/entities/user.dart';
import 'package:khola_chithi/features/auth/domain/usecases/check_auth_status.dart';
import 'package:khola_chithi/features/auth/domain/usecases/sign_in.dart';
import 'package:khola_chithi/features/auth/domain/usecases/sign_out.dart';

class AppAuthProvider with ChangeNotifier {
  final SignIn signInUseCase;
  final SignOut signOutUseCase;
  final CheckAuthStatus checkAuthStatusUseCase;

  User? _user;
  User? get user => _user;
  bool isLoggedIn = false;

  AppAuthProvider({
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.checkAuthStatusUseCase,
  });

  Future<void> signIn(String email, String password) async {
    _user = await signInUseCase(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await signOutUseCase();
    _user = null;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    _user = await checkAuthStatusUseCase();
    isLoggedIn = _user !=null;
    notifyListeners();
  }
}
