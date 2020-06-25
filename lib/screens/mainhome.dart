import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uniresto/api/api.dart';
import 'package:uniresto/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:uniresto/screens/tabbody.dart';
import 'dart:async';

import '../catagory.dart';
import 'api.dart';
class mainhome extends StatefulWidget {
  @override
  _mainhomeState createState() => _mainhomeState();
}

class _mainhomeState extends State<mainhome> with SingleTickerProviderStateMixin  {

 String _restaurantName;
 List<String> _tabTitleList;
 TabController tabController;
 List<DishItem> _allData;

  @override
  void initState() {
    super.initState();
    startLoading();
  }

 startLoading() async {
   var name = await getName();
   var tab = await getTableMenuItems();
   var temp2 = await getAllData();


   setState(() {
     _restaurantName = name;
     _tabTitleList = tab;
     _allData = temp2;


   });
   tabController =
   new TabController(length: _tabTitleList.length, vsync: this);
   print(_tabTitleList);

 }


  @override
  Widget build(BuildContext context) {
    return  _tabTitleList != null && _allData != null && _restaurantName != null
        ?
    Scaffold(
      appBar: AppBar(
        title: (
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[


                Text(_restaurantName,
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('My Orders',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1.0,
                    fontFamily: 'Montserrat',
                    color: Colors.grey,
                  ),
                ),
                Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      iconSize: 25,
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => home(),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ],
            )
        ),



        backgroundColor: Colors.white,
        elevation: 0.0,
    bottom: TabBar(
    labelColor: Colors.red,
    indicatorColor: Colors.red,
    unselectedLabelColor: Colors.grey,
    isScrollable: true,
    tabs: _tabTitleList.map((e) => Tab(child: Text(e))).toList(),
    controller: tabController,
      ),
    ),
      body: TabBarView(
        controller: tabController,
          children: _tabTitleList
              .map((e) => TabBody(
            items: _allData
                .where((element) => element.category == e)
                .toList(),

          ))
              .toList()



      ),
    )  : Loading();

  }



}


class Loading extends StatelessWidget {
  const Loading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}