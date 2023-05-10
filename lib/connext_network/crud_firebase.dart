import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ConnecFirebase{

  ConnecFirebase._internal();
  static final ConnecFirebase  _instance =  ConnecFirebase._internal();
  factory ConnecFirebase() {
    return _instance;
  }

  Future createUser({ required UserCredential u_id ,required String name, required String email,required String pass,required File imageFile}) async {
  try{
    log("11111 ${imageFile}");
    final ref = FirebaseStorage.instance.ref().child("userprofile/").child("${email}");
    await ref.putFile(imageFile);
    String imageURL = await ref.getDownloadURL();
    final docUsers = FirebaseFirestore.instance.collection('users').doc(u_id.user!.uid);
    final json = {
      "name": name,
      "uid":u_id.user!.uid,
      "email": email,
      "password": pass,
      "role": 0,
      "profile":imageURL,
      "create_at": DateTime.now()
    };
    await docUsers.set(json);

  }catch(e){
    log("catch Error::::${e}");
  }


  }

  Future updateUser({
    required final Map<String, dynamic> u_id
  }) async {
    try{
      final docUsers = FirebaseFirestore.instance.collection('users').doc("${u_id['uid']}");
      final json = {
        "role": 1,
      };
      await docUsers.update(json);

    }catch(e){
      log("catch Error::::${e}");
    }


  }






}


