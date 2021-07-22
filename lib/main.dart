import 'package:flutter/material.dart';
import 'package:interview_demo/Database/Database.dart';
import 'package:interview_demo/Models/AddingMeals.dart';
import 'package:interview_demo/Models/Meals.dart';
import 'package:interview_demo/Models/Order.dart';
import 'package:interview_demo/Models/Stores.dart';

import 'AccountPage.dart';
import 'HomePage.dart';
import 'OrderPage.dart';
import 'PremiumPage.dart';
import 'SearchPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

List<Meals> cartList = [];
String orderStoreName;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> viewScreen = [
    HomePage(),
    SearchPage(),
    OrderPage(),
    AccountPage(),
    PremiumPage(),
  ];

  int _currentIndex = 0;

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewScreen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemClick,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 32.0,
            ),
            title: Text(
              '首頁',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
              size: 32.0,
            ),
            title: Text(
              '瀏覽',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmarks,
              size: 32.0,
            ),
            title: Text(
              '訂單',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              size: 32.0,
            ),
            title: Text(
              '帳戶',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.confirmation_num_sharp,
              size: 32.0,
            ),
            title: Text(
              '取得通行證',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
