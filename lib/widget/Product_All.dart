import 'package:appshop/connext_network/crud_node.dart';
import 'package:appshop/model/json_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductAll extends StatefulWidget {
  const ProductAll({Key? key, required this.dataUser}) : super(key: key);

  final Map<String, dynamic> dataUser;


  @override
  State<ProductAll> createState() => _ProductAllState();
}

class _ProductAllState extends State<ProductAll> {
  int activeIndex = 0;
  final controller = CarouselController();

  SnackBar snackBar (Color colors, String status)=> SnackBar(
      backgroundColor: colors,
      content: Text(status),
      action: SnackBarAction(
        label: 'ปิด',
        onPressed: () {
          // Some code to undo the change.
        },
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        children: [
          Card(
            color: Colors.greenAccent,
            elevation: 5,
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Top 3 สินค้าประจำเดือน เมษายน",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: 3,
                    options: CarouselOptions(
                        height: 400,
                        autoPlay: true,
                        pageSnapping: true,
                        enableInfiniteScroll: false,
                        autoPlayInterval: Duration(seconds: 2),
                        //    enlargeStrategy: CenterPageEnlargeStrategy.height,

                        //   autoPlayAnimationDuration: Duration(seconds: 2)
                        enlargeCenterPage: true,
                        //  reverse: true
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index)),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: GestureDetector(
                              onTap: () {
                                print("Container clicked");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5, color: Colors.amber)),
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  decoration: ShapeDecoration(
                                                      color: Colors.amber,
                                                      shape: CircleBorder()),
                                                  child: Text(
                                                    "${index}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  width: 15,
                                                  height: 15,
                                                  alignment: Alignment.center,
                                                ),
                                                Container(
                                                  height: 90,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0E7sMqg7DRgg-j8XMi6wa38VkgSE8f6u1sA&usqp=CAU"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                            ),
                                            Column(
                                              children: [
                                                Text("name product"),
                                                Text("ราคา 100 "),
                                                Text("ขายไปแล้ว 1,000 "),
                                                Row(
                                                  children: [
                                                    Text("เหลือ 320  "),
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(Icons
                                                          .store_mall_directory_outlined),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                        ),
                                      ]),
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                ),
                nextimage()
              ],
            ),
          ),
          Card(
              child: Container(
                  alignment: Alignment.center,
                  height:MediaQuery.of(context).size.height *0.05 ,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Text("รายการสินค้า"))),
          Expanded(
            child: FutureBuilder(
              future:ConnecNetwork().getproductAll_forSell() ,
              builder: (context, snapshot) {
                if(snapshot.hasData){

                  List<Testjason>? testjason = snapshot.data;
                  if (testjason == null) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.topCenter,
                      child: Text("No data"),
                    );
                  }
                  return buildProductAll_For_sell(testjason);

                }
                return Center(
                  child: CircularProgressIndicator(),);
              },

            ),
          )
        ],
      ),
    );
  }

  Container buildProductAll_For_sell(List<Testjason>testjason) {

    return Container(
                  child: GridView.builder(

                    itemCount:testjason.length ,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {

                      return Stack(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:  (testjason[index].imageProduct == null || testjason[index].imageProduct.isEmpty) ?
                                              NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0E7sMqg7DRgg-j8XMi6wa38VkgSE8f6u1sA&usqp=CAU")
                                              : NetworkImage(testjason[index].imageProduct),
                                              fit: BoxFit.fill),
                                        ),
                                        height:
                                        MediaQuery.of(context).size.height * 0.2,

                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${testjason[index].nameProduct}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          //  crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text("\$ ${testjason[index].price}"),
                                            Text("เหลือ ${testjason[index].amount} ตัว"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          IconButton(onPressed: (){
                            
                           ConnecNetwork().buyProduct(widget.dataUser, testjason[index].nameProduct, testjason[index].imageProduct, testjason[index].price, testjason[index].amount,buy: 1).then((value) => {
                             ScaffoldMessenger.of(context).showSnackBar(snackBar(Colors.greenAccent,"เพิ่มสินค้าเข้าไปในตะกร้า เรียบร้อยแล้ว"))
                           });

                            
                          }, icon: Icon(Icons.shopping_cart,color: Colors.amber,))
                        ],
                      );
                    },
                  ),
                );
  }

  Widget nextimage() {
    return Center(
      child: AnimatedSmoothIndicator(
        onDotClicked: Clicked_next,
        activeIndex: activeIndex,
        count: 3,
        effect: JumpingDotEffect(
            dotHeight: 10,
            dotWidth: 15,
            dotColor: Colors.grey,
            activeDotColor: Colors.amber),
      ),
    );
  }
  void Clicked_next(int intdex) => controller.animateToPage(intdex);
}
