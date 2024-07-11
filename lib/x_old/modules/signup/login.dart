
import 'package:flutter/material.dart';
import 'package:khola_chithi/widgets/my_button.dart';
import 'package:khola_chithi/widgets/my_textfield.dart';
import 'package:khola_chithi/x_old/auth_controller.dart';
import 'package:provider/provider.dart';

//create password controller and email controller in my class

class Login extends StatefulWidget {
  final void Function()? toggle;
  const Login({super.key, required this.toggle});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
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
                      controller: values.emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextfield(
                      hintText: "Password",
                      obscureText: true,
                      controller: values.passwordController,
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
                      onTap: () => values.logIn(context),
                    ),

                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: widget.toggle,
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
