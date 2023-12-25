import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/firebase_options.dart';
import 'package:recruiter/screens/home_screen.dart';
import 'package:recruiter/screens/signup_screen.dart';

import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    routes: {
      '/': (context) => const LoginScreen(),
      '/SignUpScreen': (context) => const SignUpScreen(),
      '/HomeScreen': (context) => const HomeScreen(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
