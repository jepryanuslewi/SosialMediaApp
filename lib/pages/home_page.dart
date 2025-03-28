import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/component/my_postbtn.dart';
import 'package:socialmediaapp/database/firestore_databases.dart';
import 'package:socialmediaapp/pages/profil_page.dart';
import 'package:socialmediaapp/pages/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController postController = TextEditingController();

  // firestore database acces
  final FirestoreDatabases database = FirestoreDatabases();

  void postMessage() {
    // Only post message if there is something in the textfield
    if (postController.text.isNotEmpty) {
      String message = postController.text;
      database.addPost(message);
    }

    // Clear the textfield
    postController.clear();
  }

  User? user = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot<Map<String, dynamic>>> getMyProfile() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Chat-App"),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 280,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 40),
                margin: EdgeInsets.only(top: 90, bottom: 10),
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: getMyProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // ekstrak data
                      Map<String, dynamic>? user = snapshot.data!.data();
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 100),
                          ),
                          SizedBox(height: 10),
                          Text(user!["username"]),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),

              ListTile(
                title: Text("Profile"),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilPage()),
                  );
                },
              ),
              ListTile(
                title: Text("Users"),
                leading: Icon(Icons.people),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
              ),
              ListTile(
                title: Text("Delete Account"),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  FirebaseAuth.instance.currentUser!.delete();
                },
              ),

              // Logout
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: postController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Say something . . .",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: MyPostbtn(onTap: postMessage),
              ),
            ],
          ),
          StreamBuilder(
            stream: database.getPostStream(),
            builder: (context, snapshot) {
              // Loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              // Get all post
              final posts = snapshot.data!.docs;

              // No post
              if (snapshot.data == null || posts.isEmpty) {
                return Center(child: Text("No post found"));
              }

              // Display post
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    String message = post['PostMessage'];
                    String email = post['UserEmail'];

                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ListTile(
                        title: Text(message, style: TextStyle(fontSize: 20)),
                        subtitle: Text(
                          email,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
