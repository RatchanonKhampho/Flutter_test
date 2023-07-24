import 'package:flutter/material.dart';
import '../service/auth_service.dart';

const kHomeStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: Colors.blue,
);

class HomeScreen extends StatelessWidget {
  final AuthService auth;
  HomeScreen({required this.auth});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            child: Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
            onPressed: auth.logout,
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home Page',
                style: kHomeStyle,
              ),
              SizedBox(
                height: 30,
              ),
              auth.currentUser != null
                  ? Text(
                      'รหัสผู้ใช้: ${auth.currentUser!.uid}',
                    )
                  : Container(),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
