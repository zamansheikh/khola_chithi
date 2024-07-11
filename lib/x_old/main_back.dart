
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khola_chithi/x_old/login_or_signup.dart';
import 'package:khola_chithi/x_old/auth_controller.dart';
import 'package:khola_chithi/theme/dark_mode.dart';
import 'package:khola_chithi/theme/light_mode.dart';
import 'package:provider/provider.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthController(),
      child: MaterialApp(
        theme: lightMode,
        darkTheme: darkMode,
        debugShowCheckedModeBanner: false,
        title: 'Khola Chithi',
        home: const LoginOrSignup(),
      ),
    ),
  );
}

// import 'dart:async';

// void main() async {
//   await for (final name in someName().asyncExpand((names)=>times3Iterable(names))){
//     print(name);
//   }
// }

// Stream<String> someName() async* {
//   yield "Zaman Sheikh";
//   yield "Rubana Mahjabin";
// }

// Stream<String> times3Iterable(String name) => Stream.fromIterable(
//       Iterable.generate(3, (_) => name),
//     );

// Future<void> broadCastStream() async {
//   final controller = StreamController<String>.broadcast();
//   final sub1 = controller.stream.listen(
//     (event) {
//       print(event);
//     },
//   );
//   final sub2 = controller.stream.listen(
//     (event) {
//       print(event);
//     },
//   );

//   controller.sink.add("Zaman");
//   controller.sink.add("Sheikh");
//   controller.close();
//   controller.onCancel = () {
//     sub1.cancel();
//     sub2.cancel();
//   };
// }

// Stream<String> getNameAndAll() async* {
//   yield "Zaman";
//   yield "Sheikh";
//   throw Exception("No More Names | NameOutOFBound");
// }

// void SomeThing() async {
//   final controller = StreamController<String>();
//   controller.sink.add("zaman");
//   controller.sink.add("sheikh");

//   for (var i = 0; i < 10; i++) {
//     controller.sink.add("sheikh $i");
//   }
//   await for (String i in controller.stream) {
//     print(i);
//   }

//   controller.close();
// }

// Stream<String> femaleName() async* {
//   yield "Rubana";
//   yield "Mahjabin";
// }

// Stream<String> maleName() async* {
//   await Future.delayed(const Duration(seconds: 2));
//   yield "Zaman";
//   yield "Sheikh";
// }

// Stream<String> getMaleAndFemaleName() async* {
//   yield* femaleName();
//   yield* maleName();
// }

// typedef MyFunction = bool Function(int);

// bool evenNumber(int number) {
//   return number % 2 == 0;
// }

// bool oddNumber(int number) {
//   return number % 2 != 0;
// }

// Stream<int> getSomeThingNew(int start, int end, MyFunction f) async* {
//   for (var i = start; i <= end; i++) {
//     if (f(i)) {
//       await Future.delayed(const Duration(seconds: 1), () {});
//       yield i;
//     }
//   }
// }

// Stream<int> getNumbe() async* {
//   int var1 = 1000;
//   int var2 = var1;
//   for (var i = 0; i < var1; i++) {
//     await Future.delayed(const Duration(milliseconds: 1), () {});
//     print("Please wait $var2 milliseconds");
//     var2--;
//     yield i;
//   }
// }

// Stream<String> getNamess() async* {
//   await Future.delayed(const Duration(seconds: 2));
//   yield "Zaman";
//   await Future.delayed(const Duration(seconds: 2));
//   yield "Sheikh";
// }

// Stream<String> getCharacters(String name) async* {
//   for (var i = 0; i < name.length; i++) {
//     await Future.delayed(const Duration(seconds: 1));
//     yield name[i];
//   }
// }

// Stream<int> getStream(int start, int end) async* {
//   for (var i = start; i <= end; i++) {
//     await Future.delayed(const Duration(seconds: 1), () {});
//     yield i;
//   }
// }

// Iterable<int> getRange(int start, int end) sync* {
//   for (var i = start; i <= end; i++) {
//     yield i;
//   }
// }

// String waiting() => "Plese wait 4 seconds";

// Future<String> getLength(String name) async {
//   await Future.delayed(const Duration(seconds: 2));
//   return name.length.toString();
// }

// Future<String> putName() {
//   return Future.delayed(
//     const Duration(seconds: 2),
//     () => "Zaman Sheikh",
//   );
// }

// Future<String> getNotes({
//   required String firstName,
//   required String lastName,
// }) {
//   if (firstName.isEmpty || lastName.isEmpty) {
//     throw CustomException("Name is empty");
//   } else {
//     return Future.value("The person name is $firstName $lastName ");
//   }
// }

// class CustomException implements Exception {
//   final String message;
//   CustomException(this.message);
// }

// Future<String> getZipCode() {
//   return Future.delayed(
//     const Duration(seconds: 2),
//     () => "Hello World",
//   );
// }
