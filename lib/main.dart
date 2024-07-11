import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:khola_chithi/features/auth/presentation/pages/login_page.dart';
import 'package:khola_chithi/features/auth/presentation/pages/initializer_page.dart';
import 'package:khola_chithi/features/post/presentation/providers/post_provider.dart';
import 'package:khola_chithi/features/auth/presentation/pages/signup.dart';
import 'package:khola_chithi/firebase_options.dart';
import 'package:khola_chithi/theme/dark_mode.dart';
import 'package:khola_chithi/theme/light_mode.dart';
import 'package:provider/provider.dart';
import 'package:khola_chithi/features/auth/presentation/providers/app_auth_provider.dart';
import 'package:khola_chithi/injection_container.dart' as di;
import 'package:khola_chithi/features/post/presentation/pages/posts_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<AppAuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<PostProvider>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        initialRoute: '/',
        routes: {
          '/': (context) => const InitializerPage(),
          '/posts': (context) => const PostsPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const Signup(),
        },
      ),
    );
  }
}
