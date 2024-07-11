import 'package:flutter/material.dart';
import 'package:khola_chithi/x_old/auth_controller.dart';
import 'package:khola_chithi/x_old/modules/home/home.dart';
import 'package:khola_chithi/x_old/modules/signup/login.dart';
import 'package:khola_chithi/x_old/modules/signup/signup.dart';
import 'package:provider/provider.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool isLogin = true;

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (context, values, child) {
      if (values.user == null) {
        if (isLogin) {
          return Login(toggle: toggle);
        } else {
          return Signup(toggle: toggle);
        }
      } else if (values.user != null) {
        return const Home();
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
