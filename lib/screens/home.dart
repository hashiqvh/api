import 'package:flutter/material.dart';
import 'package:uniresto/api/api.dart';
import 'package:uniresto/screens/mainhome.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin{
  String _restaurantName;

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  startLoading() async {
    var name = await getName();


    setState(() {
      _restaurantName = name;



    });


  }

  @override
  Widget build(BuildContext context) {
    return
       _restaurantName != null
          ?
      Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height:150,
            ),
            Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 50,
                letterSpacing: 3.0,

                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                _restaurantName,
                style: TextStyle(
                  fontSize: 35,
                  letterSpacing: 3.0,
                  fontWeight: (
                      FontWeight.bold
                  ),
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height:150,
            ),
            MaterialButton(onPressed: (){

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      mainhome(),
                ),
              );
            },
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ),
    ) : Loading();
  }
}