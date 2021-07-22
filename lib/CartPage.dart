import 'package:flutter/material.dart';
import 'package:interview_demo/Database/Database.dart';
import 'package:interview_demo/Models/Meals.dart';
import 'package:interview_demo/Models/Order.dart';
import 'package:interview_demo/main.dart';
import 'package:intl/intl.dart'; //日期套件

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '您的餐點',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                    width: MediaQuery.of(context).size.width,
                    height: 150.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7 - 10,
                          height: 100.0,
                          child: Column(
                            children: [
                              Text(
                                cartList[index].title,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                              Text(cartList[index].description),
                              Text(
                                '\$ ${cartList[index].price.toString()}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100.0,
                          width: MediaQuery.of(context).size.width * 0.3 - 10,
                          child: Image.asset(cartList[index].imageAsset),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 10.0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          cartList.remove(cartList[index]);
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey[400],
                        size: 35.0,
                      ),
                    ),
                  )
                ],
              );
            }, childCount: cartList.length),
          ),
        ],
      ),
      floatingActionButton: FlatButton(
        color: Colors.black,
        onPressed: () {
          String nowTime = DateFormat.yMMMd().format(DateTime.now());
          // DatabaseHelper mealsDatabase = DatabaseHelper(nowTime, 1);

          int totalPrice = 0;
          for (int i = 0; i < cartList.length; i++) {
            // mealsDatabase.insertData(null, cartList[i], null, null);

            totalPrice += cartList[i].price;
          }

          Order order = Order(orderStoreName, nowTime, totalPrice, '');

          DatabaseHelper orderDatabase = DatabaseHelper('orderTable', 3);
          orderDatabase.insertData(null, null, null, order);

          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50.0,
          child: Text(
            '結帳',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
