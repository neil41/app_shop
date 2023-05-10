
import 'dart:developer';
import 'package:appshop/Ahut/register.dart';
import 'package:appshop/connext_network/firebase.dart';
import 'package:appshop/page/customer_page/home_User.dart';
import 'package:appshop/page/seller_page/home_seller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final AuthService _auth = AuthService();
  TextEditingController Controllerusername = TextEditingController();
  TextEditingController Controllerpassword = TextEditingController();

// ignore: non_constant_identifier_names
TextFormField Input_auth(String labelText, TextEditingController controller,{Icon? icon,String? regex,String? initut_data,String? errorText}) {
  return TextFormField(
    // onChanged: (val){
    //   _formkey.currentState?.validate();
    // },
    keyboardType: TextInputType.text,
    //  decoration:buildInputDecoration(Icons.email,"Email"),
    validator: (value){

      print(value);
      if(value!.isEmpty){
        return "${initut_data}";
      }else if(!RegExp(regex.toString()).hasMatch(value))
      {
        return  errorText;
      }
      return null;
    },
    controller: controller,
    decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        suffixIconColor: Colors.blue[700]),
    style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold),
  );
}
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
    return StreamBuilder<User?>(
stream:  _auth.user,
      builder: (context, snapshot) {
        return FutureBuilder<Map<String, dynamic>>(
          future: _auth.getUserData(),
          builder: (context,  AsyncSnapshot<Map<String, dynamic>> userDataSnapshot) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://img.freepik.com/free-photo/planks-with-blurred-store-background_1253-39.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
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
                          margin: const EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Text(
                                "Shop",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lobster(

                                  fontSize: 35
                                ),

                              ),
                            ],
                          ),
                        ),
                        // ignore: avoid_unnecessary_containers
                        Card(
                          color: Colors.white24,
                          elevation: 50,
                          margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                          child: Container(
                            child: Form(
                                key: _formkey,
                                child:
                                Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 60.0, 10.0),
                                        child: Input_auth(icon: Icon(Icons.email_outlined,color: Colors.black38),"username", Controllerusername,regex: r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[c]+[o]+[m]" ,initut_data: "กรุณากรอก อีเมล",errorText:"กรุณากรอกอีเมล ให้ถูกต้อง" )),
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 60.0, 10.0),
                                        child: Input_auth(icon: Icon(Icons.key,color: Colors.black38),"password", Controllerpassword,regex: r"^[0-9]+$" ,initut_data: "กรุณากรอก รหัสผ่าน",errorText: "กรุณากรอกรหัสผ่าน ให้ถูกต้อง ได้เฉพาะ 0-9")),

                                  ],
                                )),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                                margin:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 5.0),
                                child: OutlinedButton(
                                    onPressed: () {
                                      if(_formkey.currentState!.validate()){

                                        FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                            email:Controllerusername.text ,
                                            password: Controllerpassword.text)
                                            .then((value) async{
                                          print("ผ่านนนนนนนนนนนนนนนนนนนน");
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar(Colors.greenAccent,"สำเร็จ"));
                                          //log("${userDataSnapshot.data!['row']}");
                                          if(userDataSnapshot.data!['role']==0){
                                            log("userrrrrrrrrrrrrrrrrrrrrr}");

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Homeuser(dataUser: userDataSnapshot.data!),
                                                )).onError((error, stackTrace) {
                                              log("errpr:::::::${error.toString()}");
                                            });


                                          }else if(userDataSnapshot.data!['role']==1){
                                            log("adminnnnnnnnnnnnnnnnn}");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeSeller(dataUser: userDataSnapshot.data!),
                                                )).onError((error, stackTrace) {
                                              log("errpr:::::::${error.toString()}");
                                            });

                                          }
                                        }).onError((error, stackTrace) {
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar(Colors.red,'ไม่สำเร็จ'));
                                          print("ไม่ผ่านนนนนนนนนนนนนนนนนนนน");

                                        });


                                      }
                                    },
                                    child: const Text("ตกลง"))),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Regidter(),
                                    ));
                              },
                              child: const Text(
                                "ลงทะเบียน?",
                                style: TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),),),
          );
        },);
      },

    );
  }


}
