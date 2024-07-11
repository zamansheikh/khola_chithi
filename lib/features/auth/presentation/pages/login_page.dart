import 'package:flutter/material.dart';
import 'package:khola_chithi/core/utils/helper_function.dart';
import 'package:khola_chithi/features/auth/presentation/providers/app_auth_provider.dart';
import 'package:khola_chithi/widgets/my_button.dart';
import 'package:khola_chithi/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

//create password controller and email controller in my class

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthProvider>(
      builder: (context, values, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //add a png
                    Image.asset(
                      "assets/chithi.png",
                      height: 200,
                    ),

                    //App title
                    Text(
                      "K H O L A   C H I T H I",
                      // "খো লা   চি ঠি",
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),

                    const SizedBox(height: 25),

                    //email input field
                    MyTextfield(
                      hintText: "Email",
                      obscureText: false,
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextfield(
                      hintText: "Password",
                      obscureText: true,
                      controller: _passwordController,
                    ),

                    const SizedBox(height: 10),

                    //forgot password button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    //login button
                    MyButton(
                      text: "Login",
                      onTap: () {
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          values.signIn(
                              _emailController.text, _passwordController.text);
                        } else {
                          displaySnackBar(
                              context, "Please fill all the fields");
                        }
                      },
                    ),

                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/signup");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          const SizedBox(width: 5),
                          const Text("Sign Up",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
