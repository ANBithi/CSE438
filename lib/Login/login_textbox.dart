import 'package:flutter/material.dart';

class TextBoxLogin extends StatelessWidget {
  const TextBoxLogin({
    super.key,
    required this.controller,
    required this.field,
  });

  final TextEditingController controller;
  final String field;
  @override
  Widget build(BuildContext context) {
    String labelText = "";
    bool obsecureText = false;
    IconData icon;
    if (field == "email") {
      icon = Icons.email;
      labelText = "Email";
    } else {
      icon = Icons.lock;
      labelText = "Password";
      obsecureText = true;
    }
    return Container(
      width: 300.0,
      child: TextFormField(
        obscureText: obsecureText,
        controller: controller,
        cursorColor: Color(0xFF5951BE),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Color(0xFF5951BE)),
          prefixIcon: Icon(icon, color: Color(0xFF5951BE)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF5951BE)),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF5951BE)),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {}
          return null;
        },
      ),
    );
  }
}
