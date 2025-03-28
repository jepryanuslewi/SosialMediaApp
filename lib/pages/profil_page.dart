import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<ProfilPage> {
  // Current user logged in
  User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // Error
            else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            // Data Received
            else if (snapshot.hasData) {
              // Extract data
              Map<String, dynamic>? user = snapshot.data!.data();

              return Column(
                children: [
                  SizedBox(height: 30),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 60,
                    child: Icon(Icons.person, size: 70),
                  ),

                  SizedBox(height: 30),
                  // Username
                  Text(
                    user!['username'],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  // Email
                  Text(
                    user['email'],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("No data"));
            }
          },
        ),
      ),
    );
  }
}
