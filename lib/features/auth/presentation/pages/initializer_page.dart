import 'package:flutter/material.dart';
import 'package:khola_chithi/features/auth/presentation/pages/login_page.dart';
import 'package:khola_chithi/features/post/presentation/pages/posts_page.dart';
import 'package:provider/provider.dart';
import 'package:khola_chithi/features/auth/presentation/providers/app_auth_provider.dart';

class InitializerPage extends StatelessWidget {
  const InitializerPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthProvider>(
      builder: (context, value, _) {
        value.checkAuthStatus();
        if (value.isLoggedIn) {
          return  PostsPage();
        } else {
          return const LogInPage();
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}