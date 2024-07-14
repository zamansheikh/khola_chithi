import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khola_chithi/features/auth/presentation/pages/login_page.dart';
import 'package:khola_chithi/features/auth/presentation/providers/app_auth_provider.dart';
import 'package:khola_chithi/features/post/presentation/pages/posts_page.dart';
import 'package:provider/provider.dart';

class InitializerPage extends StatelessWidget {
  const InitializerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('An error occurred!'),
            ),
          );
        }
        if (snapshot.hasData) {
          authProvider.checkAuthStatus();
          return const PostsPage();
        }
        return const LoginPage();
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
