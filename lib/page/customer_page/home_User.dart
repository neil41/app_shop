
import 'package:another_flushbar/flushbar.dart';
import 'package:appshop/Ahut/login.dart';
import 'package:appshop/connext_network/crud_firebase.dart';

import 'package:appshop/widget/Product_All.dart';
import 'package:appshop/widget/follow_product.dart';
import 'package:appshop/widget/my_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homeuser extends StatefulWidget {
  const Homeuser({Key? key, required this.dataUser}) : super(key: key);
  final Map<String, dynamic> dataUser;

  @override
  State<Homeuser> createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int item_inbody = 0;
  void show_Custom_Flushbar(BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),

      backgroundGradient: LinearGradient(
        colors: [
          Colors.pink.shade500,
          Colors.pink.shade300,
          Colors.pink.shade100
        ],
        stops: [0.4, 0.7, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'This is a floating Flushbar',
      message: 'Welcome to Flutter community.',
      messageSize: 17,
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              key: _key,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.home_outlined, size: 35),
                  onPressed: () {
                    item_inbody = 0;
                    setState(() {});
                  },
                ),
                actions: [
                  IconButton(onPressed: (){
                    showDialog(context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("เปิดร้านค้า"),
                          content: Text("กรุณายืนยันเพื่อจะขายสินค้า และ กรุณาเข้าสู่ระบบใหม่อีกครั้ง") ,
                          actions: [
                            Row(

                              children: [
                                ElevatedButton(onPressed:

                                    (){

                                  ConnecFirebase().updateUser(u_id:widget.dataUser );

                                  InkWell(
                                    onTap: (){
                                      show_Custom_Flushbar(context);
                                    },
                                  );

                                  Navigator.pop(context);
                                }, child: Text("ยืนยัน")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                    ),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("ยกเลิก")),

                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            )
                          ],
                        );
                      },

                    )     ;

                  }, icon: Icon(Icons.store_mall_directory,color: widget.dataUser['role']==1?Colors.green:null,)),
                  profile(),

                ],
              ),
              endDrawer: buildDrawer(context),
              body: item_inbody == 0
                  ? ProductAll(dataUser: widget.dataUser,)
                  : item_inbody == 1
                      ? Myproduct(dataUser: widget.dataUser,)
                      : item_inbody == 2
                          ? FollowProduct()
                          : Container(
                              child: Center(
                                child: Text("ไม่มีข้อมูล"),
                              ),
                            ))),
    );
  }

///////////////////////////////////////////WIDGET////////////////////////////////////////////////////////////////////

  IconButton profile() {
    return IconButton(
      icon: const Icon(Icons.person_pin, size: 35),
      onPressed: () => _key.currentState!.openEndDrawer(),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Column(children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.network(
                  widget.dataUser['profile'],
                  height: 70,
                ),
              ),
              Text("${widget.dataUser['name']}")
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.673,
          color: Colors.blue,
          child: ListView(children: [
            Item_in_Drawer(
                context, const Icon(Icons.shopping_cart_outlined), "ตะกร้า",
                L_icon: const Icon(Icons.arrow_forward_ios), () {
              item_inbody = 1;
              setState(() {});
              Navigator.pop(context);
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Myproduct(),));
            }),
            Item_in_Drawer(context, const Icon(Icons.timeline), "ติดตามสินค้า",
                () {
              item_inbody = 2;
              setState(() {});
              Navigator.pop(context);
            }, L_icon: const Icon(Icons.arrow_forward_ios)),
            Item_in_Drawer(
                context,
                const Icon(Icons.output_outlined),
                "ออกจากระบบ",
                () =>

                    FirebaseAuth.instance.signOut().then((value) => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ))
                })

                ),
          ]),
        ),
      ]),
    );
  }

  InkWell Item_in_Drawer(
      BuildContext context, Icon Ficon, String name, VoidCallback ontap,
      {Icon? L_icon}) {
    return InkWell(
      child: Card(
        child: Container(
            color: Colors.white,
            child: TextButton(
              onPressed: ontap,
              child: Text(name),
            )

            // ListTile(
            //     focusColor: Colors.red,
            //     selectedColor: Colors.red,
            //     trailing: Licon,
            //     leading: Ficon,
            //     title: Text(name),
            //     onTap: ontap),
            ),
        elevation: 5,
      ),
    );
  }
}
