import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthService auth;
  late Stream<User?> user;
  @override
  void initState() {
    super.initState();
    auth = AuthService();
    user = auth.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(
              auth: auth,
            );
          }
          return LoginScreen(
            auth: auth,
          );
        });
  }
}
