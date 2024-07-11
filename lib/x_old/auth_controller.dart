import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khola_chithi/core/utils/helper_function.dart';
import 'package:khola_chithi/x_old/firestore.dart';

class AuthController extends ChangeNotifier {
  //USER_CREDENTIALS
  UserCredential? userCredential;
  static final FireStoreService fireStoreService = FireStoreService();
  User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  List<DocumentSnapshot> posts = [];
  DocumentSnapshot? lastDoc;
  DocumentSnapshot? lastPostByfinalDoc;
  bool isLoading = false;

  void getLastPost() async {
    Stream<QuerySnapshot<Object?>> query = fireStoreService.getLastPost();
    lastPostByfinalDoc = (await query.first).docs.first;
  }

  Future<void> fetchPosts() async {
    if (isLoading) return;
    isLoading = true;
    fireStoreService.getPostsLimit(lastDoc: lastDoc).listen((newPosts) {
      if (newPosts.docs.isNotEmpty) {
        lastDoc = newPosts.docs.last;
        posts.addAll(newPosts.docs);
        notifyListeners();
      }
      isLoading = false;
    });
  }

//Reaction Count
  Map<String, List<String>> reactions = {};
  bool isReacted(String postId) {
    if (reactions[postId] == null) {
      return false;
    } else if (reactions[postId]!.contains(user!.uid)) {
      return true;
    } else {
      return false;
    }
  }

  //SIGNUP
  Future<void> signUpUsingFirebase(
      String email, String password, String name) async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //add name email to firestore
      fireStoreService.addUser(userCredential!.user!.uid, email, name);
      user = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
    } catch (e) {
      // print(e);
    }
  }

  //SIGNIN

  Future<void> signInUsingFirebase(String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
      }
    }
  }

  //logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void signUp(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    if (passwordController.text == confirmPasswordController.text) {
      final email = emailController.text;
      final password = passwordController.text;
      final userName = userNameController.text;
      await signUpUsingFirebase(email, password, userName);
      //close the keyboard
      // ignore: use_build_context_synchronously
      FocusScope.of(context).unfocus();
      notifyListeners();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      userNameController.clear();
      emailController.clear();
      passwordController.clear();
      // print(email);
      // print(password);
      // print(userName);
    } else {
      Navigator.of(context).pop();
      displayMessage(context, "Password does not match");
    }
  }

  void logIn(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    final email = emailController.text;
    final password = passwordController.text;
    await signInUsingFirebase(email, password);
    //close the keyboard
    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
    //update the user state
    notifyListeners();
    emailController.clear();
    passwordController.clear();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  void deletPost(String id) {
    fireStoreService.deletePost(id);
    notifyListeners();
  }
}
