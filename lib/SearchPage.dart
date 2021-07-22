import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  List<String> popularList = [
    'Breakfast',
    'Taiwanese',
    'Bubble Tea',
    'Grocery',
    'Latest Deals',
    'Rewards',
    'Top Eats',
    'American',
  ];

  List<String> popularListPicture = [
    'assets/popularPicture/Breakfast and Brunch.jpg',
    'assets/popularPicture/Taiwanese.jpg',
    'assets/popularPicture/Bubble Tea.jpg',
    'assets/popularPicture/Grocery.jpg',
    'assets/popularPicture/Latest Deals.jpg',
    'assets/popularPicture/Restaurant Rewards.jpg',
    'assets/popularPicture/Top Eats.jpg',
    'assets/popularPicture/American.jpg',
  ];

  List<String> historySearch = [
    'Grocery',
    '大潤發',
    '飲料',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10.0, 30.0, 20.0, 10.0),
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.grey[300],
          ),
          child: TextField(
            onChanged: (value) {},
            focusNode: focusNode,
            controller: textEditingController,
            cursorColor: Colors.black,
            cursorHeight: 20.0,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: '餐廳、菜色、餐點',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              icon: focusNode.hasFocus
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          focusNode.unfocus();
                        });
                      },
                      highlightColor: Color.fromARGB(0, 255, 255, 255),
                      splashColor: Color.fromARGB(0, 255, 255, 255),
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        size: 30.0,
                        color: Colors.black,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          focusNode.requestFocus();
                        });
                      },
                      highlightColor: Color.fromARGB(0, 255, 255, 255),
                      splashColor: Color.fromARGB(0, 255, 255, 255),
                      icon: Icon(
                        Icons.search_outlined,
                        size: 30.0,
                        color: Colors.black,
                      ),
                    ),
              fillColor: Colors.grey[300],
              filled: true,
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '熱門類別',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SliverGrid.count(
                childAspectRatio: 4.0 / 3.0,
                crossAxisCount: 2,
                children: List<Widget>.generate(popularList.length, (index) {
                  return Stack(
                    children: [
                      Container(
                        margin: index % 2 == 0
                            ? EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0)
                            : EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                        height: 250.0,
                        child: Image.asset(
                          popularListPicture[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: index % 2 == 0
                            ? EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0)
                            : EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                        color: Color.fromARGB(100, 0, 0, 0),
                        alignment: Alignment.center,
                        child: Text(
                          popularList[index],
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  );
                }),
              )
            ],
          ),
          if (focusNode.hasFocus)
            Container(
              color: Colors.white,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '最近搜尋項目',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        onPressed: () {},
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.history,
                                size: 20.0,
                                color: Colors.grey[500],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  historySearch[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }, childCount: historySearch.length),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '熱門類別',
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
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        onPressed: () {},
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.history,
                                size: 20.0,
                                color: Colors.grey[500],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  popularList[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }, childCount: popularList.length),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
