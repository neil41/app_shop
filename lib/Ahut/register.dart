import 'dart:io';

import 'package:appshop/Ahut/login.dart';
import 'package:appshop/connext_network/crud_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Regidter extends StatefulWidget {
  const Regidter({Key? key}) : super(key: key);

  @override
  State<Regidter> createState() => _RegidterState();
}

class _RegidterState extends State<Regidter> {
  final GlobalKey<FormState> _formkeyy = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  File? imageFile;


  SnackBar snackBar (Color colors, String status)=> SnackBar(
    backgroundColor: colors,
    content: Text(status),
    action: SnackBarAction(
      label: 'ปิด',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://mpics.mgronline.com/pics/Images/558000009063001.JPEG"),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black12,
              Colors.black12,
            ])),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ลงทะเบียน",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  Form(
                      key: _formkeyy,
                      child: Column(
                        children: [
                          Input_auth(icon:Icon(Icons.email_outlined),"email", username,
                              regex: r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[c]+[o]+[m]",initut_data: "กรุณากรอก อีเมล",errorText:"กรุณากรอกอีเมล ให้ถูกต้อง"),
                          Input_auth(icon:Icon(Icons.key),"password", password, regex: r"^[0-9]+$",initut_data: "กรุณากรอก รหัสผ่าน",errorText:"กรุณากรอกรหัสผ่าน ให้ถูกต้อง ได้เฉพาะ 0-9" ),
                          Input_auth(icon:Icon(Icons.perm_contact_calendar_rounded),"name", name, regex: r"^[a-z]+",initut_data:"กรุณากรอก ชื่อ" ,errorText:"กรอกชื่อให้ถูกต้อง" )
                        ],
                      )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              getformCamera();
                            },
                            icon: Icon(Icons.photo_camera)),
                        IconButton(
                            onPressed: () {
                              gralary();
                            },
                            icon: Icon(Icons.image))
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      imageFile == null ?
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          image: DecorationImage(
                            image:  NetworkImage("https://mpics.mgronline.com/pics/Images/558000009063001.JPEG"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                      :
            Container(
            width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          image: DecorationImage(
            image:  FileImage(imageFile!),
            fit: BoxFit.fill,
          ),
        ),
      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 5.0),
                          child: OutlinedButton(

                              onPressed: () {

                                imageFile == null ?     ScaffoldMessenger.of(context).showSnackBar(snackBar(Colors.red,"กรุณา เพิ่มรูปโปรไฟล์ด้วย")):null;
                                if (_formkeyy.currentState!.validate()) {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: username.text,
                                          password: password.text)
                                      .then((u_id) async {
                                    ConnecFirebase()
                                        .createUser(
                                            u_id: u_id,
                                            name: name.text,
                                            email: username.text,
                                            pass: password.text,
                                            imageFile: imageFile!
                                    )
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Login(),
                                          ));
                                    });
                                  });
                                }
                              },
                              child: Text("ตกลง"))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getformCamera() async {
     await ImagePicker().pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        setState(() {
          imageFile = File(value.path);
        });
      }
    });
  }

  void gralary() async {
        await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
          if (value != null) {
            setState(() {
              imageFile = File(value.path);
            });
          }
        });
  }

  Container Input_auth(String labelText, TextEditingController controller,
      {Icon? icon, String? regex,String? initut_data,String? errorText}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 60.0, 10.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          print(value);
          if (value!.isEmpty) {
            return initut_data;
          } else if (!RegExp(regex.toString()).hasMatch(value)) {
            return errorText;
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: icon,
            fillColor: CupertinoColors.systemGrey5,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: labelText,
            suffixIconColor: Colors.blue[700]),
      ),
    );
  }
}
