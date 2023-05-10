import 'package:appshop/connext_network/crud_node.dart';
import 'package:appshop/model/json_model.dart';
import 'package:flutter/material.dart';

class Myproduct extends StatefulWidget {
  const Myproduct({Key? key, required this.dataUser}) : super(key: key);
  final Map<String, dynamic> dataUser;

  @override
  State<Myproduct> createState() => _MyproductState();
}

class _MyproductState extends State<Myproduct> {
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
    return FutureBuilder(
      future: ConnecNetwork().getproduct_forBuy(widget.dataUser['uid']),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Testjason>? testjason = snapshot.data;
          if (testjason == 0) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Text("No data"),
            );
          }

          return Container(
              color: Colors.black12,
              child: ListView.builder(
                itemCount: testjason!.length,
                itemBuilder: (context, index) {
                   int retuls = testjason[index].price + 40 ;
                  return Card(
                      child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.amber,
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
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
                            width:115,
                            child: Text(testjason[index].nameProduct,
                                maxLines: 2, overflow: TextOverflow.ellipsis)),
                        Row(children: [
                          ElevatedButton(onPressed: () {
                            showBottomSheet(context: context, builder: (context) =>

                                Container(
                                  padding:EdgeInsets.all(15.0) ,
                                  height: MediaQuery.of(context).size.height *0.55,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image:
                                                    (testjason[index].imageProduct == null || testjason[index].imageProduct.isEmpty) ?
                                                    NetworkImage(
                                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0E7sMqg7DRgg-j8XMi6wa38VkgSE8f6u1sA&usqp=CAU")
                                                        : NetworkImage(testjason[index].imageProduct)
                                                    ,
                                                    fit: BoxFit.fill),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.2,
                                              width: MediaQuery.of(context).size.width* 0.2,
                                            ),
                                            Column(
                                              children: [
                                                Text("ราคา ${testjason[index].price} บาท"),
                                                Text("จัดส่ง 40 บาท"),
                                                Text("รวมทั้งหมด $retuls บาท")
                                              ],
                                            ),

                                          ],
                                        ),
                                        Text(testjason[index].nameProduct),
                                        TextField(),
                                        ElevatedButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("ยืนยันการชำระเงิน")),
                                      ],
                                    ),
                                  ),
                                )
                            );

                          }, child: Text("ชำระเงิน"),),
                          IconButton(onPressed: (){
                            ConnecNetwork().delete(testjason[index].id).then((value) =>
                            {

                              setState((){}),
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(Colors.greenAccent,"สำเร็จ"))


                            });
                          //  Navigator.pop(context);
                          }, icon: Icon(Icons.delete))

                        ],)
                      ],
                    ),
                  ));

                  //   Container(
                  //   width: double.infinity,
                  //   height: 100,
                  //   margin: EdgeInsets.all(2.0),
                  //   color: Colors.pink,
                  // );
                },
              ));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

