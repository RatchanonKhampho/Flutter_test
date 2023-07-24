import 'dart:async';
import 'package:flutter/material.dart';
import '../service/auth_service.dart';

const kLoginStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: Colors.blue,
);
const kOrStyle = TextStyle(
  fontSize: 16,
  color: Colors.orange,
);
const kErrorMessage = TextStyle(
  fontSize: 16,
  color: Colors.red,
);

class LoginScreen extends StatefulWidget {
  final AuthService auth;
  LoginScreen({required this.auth});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isRegister = false;
  bool _isShowingPassword = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late StreamController<String?> errorController;
  late Stream<String?> errorStream;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    errorController = StreamController<String?>.broadcast();
    errorStream = errorController.stream;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildErrorText(),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                child: Text(
                  _isRegister ? 'ลงทะเบียน' : 'เข้าสู่ระบบ',
                  style: kLoginStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              _buildEmailLoginForm(),
              _buildAnonymous(),
            ],
          );
  }

  Widget _buildErrorText() {
    return StreamBuilder<String?>(
        stream: errorStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  snapshot.data ?? '',
                  style: kErrorMessage,
                ),
              ),
            );
          }
          return Container();
        });
  }

  Widget _buildEmailLoginForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'อีเมล'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                errorController.add(null);
              },
            ),
            Stack(
              children: [
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'รหัสผ่าน'),
                  keyboardType: TextInputType.text,
                  obscureText: _isShowingPassword,
                  onChanged: (value) {
                    errorController.add(null);
                  },
                ),
                Positioned(
                  top: 25,
                  right: 0,
                  child: GestureDetector(
                    child: _isShowingPassword
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        : Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                    onTap: () {
                      setState(() {
                        _isShowingPassword = !_isShowingPassword;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                    value: _isRegister,
                    onChanged: (newValue) {
                      setState(() {
                        _isRegister = newValue ?? false;
                      });
                    }),
                Text(_isRegister
                    ? 'เคลียร์เพื่อเข้าสู่ระบบ'
                    : 'ต้องการลงทะเบียน')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (_isRegister) {
                      try {
                        await widget.auth.creatUserWithEmail(
                            emailController.text, passwordController.text);
                      } catch (e) {
                        errorController.add(getErrorMessage(e.toString()));
                      }
                    } else {
                      try {
                        await widget.auth.loginWithEmail(
                            emailController.text, passwordController.text);
                      } catch (e) {
                        errorController.add(getErrorMessage(e.toString()));
                      }
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: Text(_isRegister ? 'ลงทะเบียน' : 'เข้าสู่ระบบ'),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    emailController.clear();
                    passwordController.clear();
                    errorController.add(null);
                  },
                  child: Text('ล้าง'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAnonymous() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'หรือ',
            style: kOrStyle,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              await widget.auth.login();
              setState(() {
                _isLoading = false;
              });
            },
            child: Text('ล็อกอินโดยไม่ระบุชื่อ'),
          ),
        ],
      ),
    );
  }

  String getErrorMessage(String errorText) {
    List<String> result = errorText.split("] ");
    return result.last;
  }
}
