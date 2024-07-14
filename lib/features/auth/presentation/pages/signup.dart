import 'package:flutter/material.dart';
import 'package:khola_chithi/core/utils/helper_function.dart';
import 'package:khola_chithi/features/auth/presentation/providers/app_auth_provider.dart';
import 'package:khola_chithi/widgets/my_button.dart';
import 'package:khola_chithi/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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

                    MyTextfield(
                      hintText: "User Name",
                      obscureText: false,
                      controller: _userNameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

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

                    const SizedBox(
                      height: 10,
                    ),

                    MyTextfield(
                      hintText: "Confirm Password",
                      obscureText: true,
                      controller: _confirmPasswordController,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

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

                    const SizedBox(
                      height: 10,
                    ),

                    //Signup button
                    Visibility(
                      visible: !context.watch<AppAuthProvider>().isLoading,
                      replacement: const CircularProgressIndicator(),
                      child: MyButton(
                        text: "SignUp",
                        onTap: () {
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            if (_userNameController.text.isNotEmpty &&
                                _emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              values.signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  _userNameController.text);
                              displayMessage(context, "Sign up successful");
                              Future.delayed(const Duration(seconds: 2)).then(
                                  (value) => Navigator.pushReplacementNamed(
                                      context, "/login"));
                            } else {
                              displaySnackBar(
                                  context, "Please fill all fields");
                            }
                          } else {
                            displaySnackBar(context, "Password does not match");
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account!",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          const SizedBox(width: 5),
                          const Text("Login",
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
