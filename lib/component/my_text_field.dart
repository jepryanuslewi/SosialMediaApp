import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    required this.text,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          hintText: text,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
