import 'package:flutter/material.dart';
import 'package:td/screens/auth/login.dart';
import 'package:td/screens/auth/signup.dart';
import 'package:td/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Scaffold(
        //     body: Center(child: CircularProgressIndicator()),
        //   );
        // }

        // Logged in
        if (snapshot.hasData) {
          return const MainScreen();
        }

        // Not logged in
        return const Signup();
      },
    );
  }
}
