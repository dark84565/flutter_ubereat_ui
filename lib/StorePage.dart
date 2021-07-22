import 'package:flutter/material.dart';
import 'package:interview_demo/Database/Database.dart';
import 'package:interview_demo/Models/Meals.dart';
import 'package:interview_demo/Models/Stores.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';

class StorePage extends StatefulWidget {
  final Stores stores;

  // final String storeName;
  // final String storePicture;

  StorePage(this.stores);

  @override
  _StorePageState createState() => _StorePageState(this.stores);
}

class _StorePageState extends State<StorePage> {
  _StorePageState(this.stores);

  Stores stores;
  Meals meals;

  // String storeName;
  // String storePicture;

  DatabaseHelper mealsDatabase;
  List<Meals> mealsList;
  int count = 0;

  @override
  void initState() {
    mealsDatabase = DatabaseHelper(stores.mealsTable, 1);
    super.initState();
  }

  void updateListView() {
    final Future<Database> dbFuture = mealsDatabase.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Meals>> mealsFuture = mealsDatabase.getMealsList();
      mealsFuture.then((mealsList) {
        setState(() {
          this.mealsList = mealsList;
          this.count = mealsList.length;
        });
      });
    });
  }

  void showDeleteDialog(BuildContext context,index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "是否新增餐點至購物車？",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
              fontFamily: '思源宋體',
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "否",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: '思源宋體',
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "是",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: '思源宋體',
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                orderStoreName = stores.title;
                setState(() {
                  cartList.add(mealsList[index]);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mealsList == null) {
      mealsList = List<Meals>();
      updateListView();
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            collapsedHeight: 50.0,
            expandedHeight: 130.0,
            floating: true,
            pinned: true,
            snap: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
                stretchModes: [StretchMode.zoomBackground],
                collapseMode: CollapseMode.pin,
                background: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250.0,
                    child: Image.asset(
                      stores.imageAsset,
                      fit: BoxFit.cover,
                    ))),
            title: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 30.0,
              child: Text(
                stores.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '您專屬的推薦商品',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showDeleteDialog(context,index);
                },
                child: Container(
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
                              mealsList[index].title,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                            Text(mealsList[index].description),
                            Text(
                              '\$ ${mealsList[index].price.toString()}',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.3 - 10,
                        child: Image.asset(mealsList[index].imageAsset),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: mealsList.length),
          ),
        ],
      ),
    );
  }
}
