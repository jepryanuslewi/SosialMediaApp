import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/component/my_button.dart';
import 'package:socialmediaapp/component/my_text_field.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

    void login() async {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );
        if (context.mounted) Navigator.pop(context); // pop the dialog
      } on FirebaseException catch (e) {
        if (context.mounted) Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text(e.code)),
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(Icons.person, size: 100),

                // nameApp
                Text(
                  'ChatApp',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 30),

                // field username
                MyTextField(
                  text: 'Email',
                  controller: _email,
                  obscureText: false,
                ),

                // field Password
                MyTextField(
                  text: 'Password',
                  controller: _password,
                  obscureText: true,
                ),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // login
                MyButton(button: 'Login', onTap: () => login()),

                SizedBox(height: 100),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have Account?"),
                    TextButton(
                      onPressed: onPressed,
                      child: Text(
                        'Register Now',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
