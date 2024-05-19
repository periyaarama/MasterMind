import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:master_mind/screens/home_screen_container_screen.dart';
import 'package:master_mind/screens/login_signup/log_in_email_one_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return HomeScreenContainerScreen();
          }

          // user is NOT logged in
          else {
            return const LogInEmailOneScreen();
          }
        },
      ),
    );
  }
}
