import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabases {
  // current user logged in
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of post from firestore
  final CollectionReference posts = FirebaseFirestore.instance.collection(
    'Post',
  );

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'User': user!.displayName,
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read post from database
  Stream<QuerySnapshot> getPostStream() {
    final postsStream =
        FirebaseFirestore.instance
            .collection('Post')
            .orderBy('TimeStamp', descending: true)
            .snapshots();

    return postsStream;
  }
}
