import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class FollowProduct extends StatefulWidget {
  const FollowProduct({Key? key}) : super(key: key);

  @override
  State<FollowProduct> createState() => _FollowProductState();
}

class _FollowProductState extends State<FollowProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                child: TimelineTile(
                  isLast: index==4?true:false,
                  endChild: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0E7sMqg7DRgg-j8XMi6wa38VkgSE8f6u1sA&usqp=CAU"),
                                fit: BoxFit.cover),
                          ),
                          width: 50,
                          height: 50,
                        ),
                        Text('  Mid'),
                      ],
                    ),
                  ),

                  beforeLineStyle: LineStyle(color: Colors.greenAccent,thickness: 6),
                  afterLineStyle: LineStyle(color: Colors.greenAccent,thickness: 6),
                  indicatorStyle: IndicatorStyle(color: Colors.pinkAccent),
                ),
              );
            },)


      ),
    );
  }
}
