import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/component/my_button.dart';
import 'package:socialmediaapp/component/my_text_field.dart';

class RegisterPages extends StatefulWidget {
  final void Function()? onPressed;
  const RegisterPages({super.key, required this.onPressed});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  void register() async {
    // loading
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // cek confirm pass
    if (_password.text != _confirmPassword.text) {
      if (context.mounted) Navigator.pop(context);
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(content: Text("Password don't match")),
      );
    } else {
      // try
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _email.text,
              password: _password.text,
            );
        Navigator.pop(context);
        print("User registered: ${userCredential.user?.uid}"); // Debugging
        // Simpan user ke Firestore
        await createUser(userCredential);
        print("Data user berhasil disimpan!");
      } on FirebaseException catch (e) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text(e.code)),
        );
      }
    }
  }

  // Create user document and add to firestrore
  Future<void> createUser(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user?.email)
          .set({
            'email': userCredential.user!.email,
            'username': _username.text,
            'password': _password.text,
          });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  text: 'Username',
                  controller: _username,
                  obscureText: false,
                ),

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

                // field Password
                MyTextField(
                  text: 'Confirm Password',
                  controller: _confirmPassword,
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
                MyButton(button: 'Register', onTap: () => register()),

                SizedBox(height: 100),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have Account?"),
                    TextButton(
                      onPressed: widget.onPressed,
                      child: Text(
                        'Login Now',
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
