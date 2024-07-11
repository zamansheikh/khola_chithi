
import 'package:flutter/material.dart';
import 'package:khola_chithi/widgets/my_button.dart';
import 'package:khola_chithi/widgets/my_textfield.dart';
import 'package:khola_chithi/x_old/auth_controller.dart';
import 'package:provider/provider.dart';

//create password controller and email controller in my class

class Signup extends StatefulWidget {
  final void Function()? toggle;
  const Signup({super.key, required this.toggle});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

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

                    MyTextfield(
                      hintText: "User Name",
                      obscureText: false,
                      controller: values.userNameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

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

                    const SizedBox(
                      height: 10,
                    ),

                    MyTextfield(
                      hintText: "Confirm Password",
                      obscureText: true,
                      controller: values.confirmPasswordController,
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
                    MyButton(
                      text: "SignUp",
                      onTap: ()=>values.signUp(context),
                    ),

                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: widget.toggle,
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
