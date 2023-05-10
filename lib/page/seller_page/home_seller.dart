import 'package:appshop/Ahut/login.dart';
import 'package:appshop/widget/Product_All.dart';
import 'package:appshop/widget/follow_product.dart';
import 'package:appshop/widget/my_product.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:appshop/page/seller_page/widget/my_shop.dart';


class HomeSeller extends StatefulWidget {
  const HomeSeller({Key? key, required this.dataUser,}) : super(key: key);

  final Map<String, dynamic> dataUser;

  @override
  State<HomeSeller> createState() => _HomeSellerState();
}

class _HomeSellerState extends State<HomeSeller> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int item_inbody = 0;


  final controller = CarouselController();
  TextEditingController priy = TextEditingController();
  TextEditingController name_product = TextEditingController();
  TextEditingController amus = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              title: item_inbody == 0
                  ? Text("เลือกซื้อสินค้า")
                  : item_inbody == 1
                  ? Text("สินค้าที่คุณหมายปอง")
                  : item_inbody == 2
                  ? Text("ติดตามสินค้า")
                  : item_inbody == 3
                  ? Text("รายการสินค้าของฉัน")
                  : Text("ไม่มีข้อมูล"),
              actions: [profile()],
            ),
            drawer: buildDrawer(context),
            body: item_inbody == 0
                ? ProductAll(dataUser: widget.dataUser,)
                : item_inbody == 1
                ? Myproduct(dataUser: widget.dataUser,)
                : item_inbody == 2
                ? FollowProduct()
                : item_inbody == 3
                ? MyShop(dataUser: widget.dataUser,)
                : Container(
              child: Center(
                child: Text("ไม่มีข้อมูล"),
              ),
            )));
  }
  ////////////////////////////////////////////////////////WIDGET//////////////////////////////////////////////////////////////////////////////
  IconButton profile() {
    return IconButton(
      icon: const Icon(Icons.person_pin, size: 35),
      onPressed: () => _key.currentState!.openDrawer(),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.65,
      child: Column(children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child:
                widget.dataUser['profile'] == null && widget.dataUser['profile'].isEmpty
          ? Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxgH5VCrq_LnoMe2clYywZ9lSRtgOz4-hzRQ&usqp=CAU",
                  height: 70,
                ):
                Image.network(
                  widget.dataUser['profile'],
                  height: 70,
                ),
              ),
              Text("${widget.dataUser['name']}")
            ],
          ),
        ),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.65,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.673,
          color: Colors.blue,
          child: ListView(children: [
            Item_in_Drawer(
                context, Icon(Icons.shopping_cart_outlined), "ตะกร้า",
                Licon: Icon(Icons.arrow_forward_ios), () {
              item_inbody = 1;
              setState(() {});
              Navigator.pop(context);
            }),
            Item_in_Drawer(context, Icon(Icons.timeline), "ติดตามสินค้า", () {
              item_inbody = 2;
              setState(() {});
              Navigator.pop(context);
            }, Licon: Icon(Icons.arrow_forward_ios)),
            Item_in_Drawer(
                context, Icon(Icons.store_mall_directory), "ร้านค้าของฉัน", () {
              item_inbody = 3;
              setState(() {});
              Navigator.pop(context);
            }, Licon: Icon(Icons.arrow_forward_ios)),
            Item_in_Drawer(
                context,
                Icon(Icons.output_outlined),
                "ออกจากระบบ",
                    () => FirebaseAuth.instance.signOut().then((value) => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ))
                      })),
          ]),
        ),
      ]),
    );
  }

  Card Item_in_Drawer(BuildContext context, Icon Ficon, String name,
      VoidCallback ontap,
      {Icon? Licon}) {
    return Card(
      child: Container(
        child: ListTile(
            focusColor: Colors.red,
            selectedColor: Colors.red,
            trailing: Licon,
            leading: Ficon,
            title: Text(name),
            onTap: ontap),
        color: Colors.white,
      ),
      elevation: 5,
    );
  }

  Container Input_auth(String labelText, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 60.0, 10.0),
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            focusColor: Colors.red,
            fillColor: CupertinoColors.systemGrey5,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white,width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            labelText: labelText,
            suffixIconColor: Colors.blue[700]),
      ),
    );
  }
}

