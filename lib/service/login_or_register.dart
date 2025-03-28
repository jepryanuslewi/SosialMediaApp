import 'package:flutter/material.dart';
import 'package:socialmediaapp/pages/login_page.dart';
import 'package:socialmediaapp/pages/register_pages.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // inisialisasi login
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onPressed: () => togglePages());
    } else {
      return RegisterPages(onPressed: () => togglePages());
    }
  }
}
