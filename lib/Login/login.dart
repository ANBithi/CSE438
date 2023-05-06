import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../Home/bottomNavigation.dart';
import '../Home/home.dart';
import 'login_textbox.dart';

class Credentials {
  final String email;
  final String password;

  Credentials({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    final credentials = Credentials(email: email, password: password);
    const String apiUrl = 'http://localhost:5000/api/auth/login';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(credentials.toJson()),
    );
    final responseData = json.decode(response.body);
    const storage = FlutterSecureStorage();
    if (responseData['success'] == true) {
      final jsonString = jsonEncode(responseData['authData']);
      await storage.write(key: 'authData', value: jsonString);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyBottomNavigation()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData['message']),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Education System'),
      ),
      body: Stack(
        children: [
          Image.asset(
            '../assets/img.png',
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent.withOpacity(0.1),
              // borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextBoxLogin(
                            controller: _emailController, field: "email"),
                        SizedBox(height: 20.0),
                        TextBoxLogin(
                            controller: _passwordController, field: "password"),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _login(context);
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5951BE),
                            foregroundColor: Color(0xFF5951BE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            minimumSize: Size(300.0, 50.0),
                            elevation: 5.0,
                            textStyle: TextStyle(fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
