import 'package:bluefeed/main.dart';
import 'package:bluefeed/screens/login.dart';
import 'package:bluefeed/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1️⃣ Still checking
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        // 2️⃣ User logged in
        if (snapshot.hasData) {
          return const BlueFeedApp();
        }

        // 3️⃣ User not logged in
        return const Login();
      },
    );
  }
}
