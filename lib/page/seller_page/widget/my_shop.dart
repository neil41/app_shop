import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:appshop/connext_network/crud_node.dart';
import 'package:appshop/model/json_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyShop extends StatefulWidget {
  const MyShop({Key? key, required this.dataUser}) : super(key: key);

  final Map<String, dynamic> dataUser;

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  TextEditingController name_product = TextEditingController();
  TextEditingController price_product = TextEditingController();
  TextEditingController amount_product = TextEditingController();
  File? imageFile;
  int addproduct = 0;
  int add = 0;
  int check_null_button = 0;

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
    return Scaffold(
      body: addproduct == 0
          ? build_Item_inMyShop()
          : addproduct == 1
              ? build_Item_addproduct()
              : Text("ไม่มีข้อมูล"),
      floatingActionButton: addproduct == 0 && add == 0
          ? FloatingActionButton(
              onPressed: () {
                show_Custom_Flushbar(context);
                print(5555555555);
                setState(() {
                  addproduct = 1;
                  check_null_button = 0;
                });
              },
              child: Icon(Icons.add_business))
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }

  RefreshIndicator build_Item_inMyShop() {
    return RefreshIndicator(onRefresh: () {
      setState(() {});
      return  Future<void>.delayed(const Duration(seconds: 2),() =>build_Item_inMyShop() ).then((value) {
        return  setState(() {}) ;
      });
    },
    child: buildContainer()

    );
  }

  Container buildContainer() {
    return Container(
    color: Colors.black12,
    child: FutureBuilder(
      future: ConnecNetwork().getproduct_forSell(widget.dataUser['uid']),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Testjason>? testjason = snapshot.data;
          if (testjason == null) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Text("No data"),
            );
          }
          return build_Ui_product(testjason);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
  );
  }

  ListView build_Ui_product(List<Testjason> testjason) {
    return ListView.builder(
      itemCount: testjason.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.blueAccent,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: (testjason[index].imageProduct == null ||
                              testjason[index].imageProduct.isEmpty)
                          ? NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0E7sMqg7DRgg-j8XMi6wa38VkgSE8f6u1sA&usqp=CAU")
                          : NetworkImage(testjason[index].imageProduct),
                    ),
                  ),
                ),
                Container(
                    width: 140,
                    child: Text(testjason[index].nameProduct,
                        maxLines: 2, overflow: TextOverflow.ellipsis)),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            add = 10;
                            check_null_button = 1;
                          });
                          showBottomSheet(
                            backgroundColor: Colors.white10,
                            context: context,
                            builder: (context) => Container(
                                padding: EdgeInsets.all(15),
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40)),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Card(
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    add = 0;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                    Icons.cancel_presentation)),
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                      ),
                                      build_addproduct(() {

                                        print(8888888888888);
                                        setState(() {
                                          addproduct = 0;
                                          add = 0;
                                        });
                                        int price =
                                            int.parse(price_product.text);
                                        int amount =
                                            int.parse(amount_product.text);
                                        ConnecNetwork().updateProduct(
                                            name_product.text,
                                            price,
                                            amount,
                                            testjason[index].id).then((value) => {
                                          setState((){
                                            show_Custom_Flushbar(context);
                                          }),
                                        });
                                        Navigator.pop(context);
                                      },
                                          nameProduct: name_product =
                                              TextEditingController.fromValue(
                                                  TextEditingValue(
                                                      text: testjason[index]
                                                          .nameProduct)),
                                          amountProduct: amount_product =
                                              TextEditingController.fromValue(
                                                  TextEditingValue(
                                                      text:
                                                          "${testjason[index].amount}")),
                                          priceProduct: price_product =
                                              TextEditingController.fromValue(
                                                  TextEditingValue(
                                                      text:
                                                          "${testjason[index].price}")),
                                          OUTbutton: Container())
                                    ],
                                  ),
                                )),
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.white)),
                    IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: (context) => Center(
                            child: SingleChildScrollView(
                              child: AlertDialog(
                                title: Text("ลบสินเค้า"),
                                content: Text("คุณยืนที่จะลบสินค้าไหม") ,
                                actions: [
                                  Row(

                                    children: [
                                    ElevatedButton(onPressed: (){
                                      ConnecNetwork().delete(testjason[index].id).then((value) =>
                                      {
                                        setState((){}),
                                      });
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
                              ),
                            ),
                          ),);

                      //    ConnecNetwork().delete(testjason[index].id);
                          print("222222222");
                        },
                        icon: Icon(Icons.delete, color: Colors.red))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container build_Item_addproduct() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: build_addproduct(
          nameProduct:name_product ,
          amountProduct: amount_product,
          priceProduct:price_product ,
              () {
                int pricee = int.parse(price_product.text);
                 int amountt = int.parse(amount_product.text);
        ConnecNetwork().createProduct(
            widget.dataUser, name_product.text, imageFile!, pricee, amountt,
            sell: 1,
        ).then((value) => {

          setState((){}),

          ScaffoldMessenger.of(context).showSnackBar(snackBar(Colors.greenAccent,"เพิ่มสินค้า สำเร็จ"))
        });
        print(8888888888888);
        setState(() {
          addproduct = 0;
          add = 0;
        });
        // Navigator.pop(context);
      },

          OUTbutton: ElevatedButton(
            onPressed: () {
              setState(() {
                addproduct = 0;
                add = 0;
              });
            },
            child: Text('ยกเลิก'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                    //  fontSize: 30,
                    fontWeight: FontWeight.bold)),
          )),
    );
  }

  SingleChildScrollView build_addproduct(VoidCallback onPressed,
      {TextEditingController? nameProduct,
      TextEditingController? priceProduct,
      TextEditingController? amountProduct,
      Widget? OUTbutton}) {


    return SingleChildScrollView(
      child: Column(children: [
        imageFile == null
            ? Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://mpics.mgronline.com/pics/Images/558000009063001.JPEG"),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  image: DecorationImage(
                    image: FileImage(imageFile!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
                child: IconButton(
                    onPressed: () {
                      getformCamera();
                    },
                    icon: Icon(Icons.photo_camera))),
            Card(
                child: IconButton(
                    onPressed: () {
                      gralary();
                    },
                    icon: Icon(Icons.image)))
          ],
        ),
        TextField(
          decoration:
              InputDecoration(labelText: "ชื่อสินค้า", hintText: "ชื่อสินค้า"),
          controller: nameProduct,
        ),
        TextField(
          decoration:
              InputDecoration(labelText: "ราคาสินค้า", hintText: "ราคาสินค้า"),
          controller: priceProduct,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "จำนวนสินค้า",
            hintText: "จำนวนสินค้า",
          ),
          controller: amountProduct,
        ),
        Row(
          mainAxisAlignment: check_null_button == 1
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: onPressed, child: Text("ตกลง")),
            OUTbutton ?? const SizedBox()
            //<-----เช็คค่า null ถ้าเป็น null ทำ SizedBox() ถ้าไม่ ทำ OUTbutton
          ],
        )
      ]),
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
}
