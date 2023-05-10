
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  // Get the currently logged in user
  Stream<User?> get user {
    return  _auth.authStateChanges();
  }

  // Get the user's name and phone number from Firestore
  Future<Map<String, dynamic>> getUserData() async {
    User? user = _auth.currentUser;


    DocumentSnapshot doc = await usersCollection.doc(user!.uid).get();

    // if(user==null){
    //   return {"logout":"aaaaa"};
    // }else{
    //   DocumentSnapshot? doc = await usersCollection.doc(user!.uid).get();
    //   return doc.data()as Map<String,dynamic>;
    // }

    return doc.data()as Map<String,dynamic>;
  }
}