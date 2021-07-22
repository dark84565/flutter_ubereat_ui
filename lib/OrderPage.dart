import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_demo/Database/Database.dart';
import 'package:interview_demo/Models/Order.dart';
import 'package:sqflite/sqflite.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DatabaseHelper orderDatabase = DatabaseHelper('orderTable', 3);
  List<Order> orderList;
  int count = 0;

  List<String> pastOrder = [
    '早餐送起司 小農鮮奶',
    '師園鹽酥雞',
    '大台北平價滷味',
    '閑茗樓 師大店',
    '肯德基 KFC 台北台大',
    'Tea top  師大店',
    '燈籠滷味 師大創始總店',
    '胖老爹 師大店',
  ];

  List<String> pastOrderPicture = [
    'assets/pastOrderPicture/早餐送起司 小農鮮奶.jpg',
    'assets/pastOrderPicture/師園鹽酥雞.jpg',
    'assets/pastOrderPicture/大台北平價滷味.jpg',
    'assets/pastOrderPicture/閑茗樓.jpg',
    'assets/pastOrderPicture/肯德基.jpg',
    'assets/pastOrderPicture/Tea top.jpg',
    'assets/pastOrderPicture/燈籠滷味.jpg',
    'assets/pastOrderPicture/胖老爹炸雞.jpg',
  ];

  List<String> orderDetails = [
    '6份餐點·\$156.00',
    '4份餐點·\$231.00',
    '6份餐點·\$140.00',
    '3份餐點·\$178.00',
    '1份餐點·\$190.00',
    '1份餐點·\$30.00',
    '5份餐點·\$85.00',
    '3份餐點·\$231.00',
  ];

  List<String> orderTime = [
    '11月08日·已完成',
    '10月16日·已完成',
    '8月22日·已完成',
    '6月22日·已完成',
    '6月14日·已完成',
    '6月06日·已完成',
    '5月20日·已完成',
    '6月25日·已完成',
  ];

  List<bool> isBusiness = [
    true,
    false,
    true,
    true,
    false,
    true,
    false,
    true,
  ];

  void updateListView() {
    final Future<Database> dbFuture = orderDatabase.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Order>> orderFuture = orderDatabase.getOrderList();
      orderFuture.then((orderList) {
        setState(() {
          this.orderList = orderList;
          this.count = orderList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (orderList == null) {
      orderList = List<Order>();
      updateListView();
    }
    debugPrint('................................................................................................');
    debugPrint(orderList.length.toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          '您的訂單',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10.0),
              child: Text(
                '過去的訂單',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return FlatButton(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(10.0, 15.0, 0, 0),
                onPressed: () {},
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 85.0,
                        margin: EdgeInsets.only(left: 10.0),
                        width: MediaQuery.of(context).size.width - 20.0,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.grey[300]),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 110.0,
                              padding: EdgeInsets.only(right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderList[index].title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '\$ ${orderList[index].price.toString()}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    orderList[index].date,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 80.0,
                              child: FlatButton(
                                padding: EdgeInsets.all(10.0),
                                height: 35.0,
                                color: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Text(
                                  '重新訂購',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: orderList.length),
          ),
        ],
      ),
    );
  }
}

// SliverList(
//   delegate: SliverChildBuilderDelegate((context, index) {
//     return FlatButton(
//       color: Colors.white,
//       padding: EdgeInsets.fromLTRB(10.0, 15.0, 0, 0),
//       onPressed: () {},
//       child: Container(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               pastOrderPicture[index],
//               height: 60.0,
//               width: 80.0,
//               fit: BoxFit.cover,
//             ),
//             Container(
//               height: 85.0,
//               margin: EdgeInsets.only(left: 10.0),
//               width: MediaQuery.of(context).size.width - 100.0,
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom:
//                       BorderSide(width: 1.0, color: Colors.grey[300]),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width - 190.0,
//                     padding: EdgeInsets.only(right: 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           pastOrder[index],
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           orderDetails[index],
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: 13.0,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Text(
//                           orderTime[index],
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: 13.0,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: 80.0,
//                     child: FlatButton(
//                       padding: EdgeInsets.all(10.0),
//                       height: 35.0,
//                       color: Colors.grey[200],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: isBusiness[index] == true
//                           ? Text(
//                               '重新訂購',
//                               style: TextStyle(
//                                 fontSize: 13.0,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             )
//                           : Text(
//                               '菜單',
//                               style: TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                       onPressed: () {},
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }, childCount: pastOrder.length),
// ),
