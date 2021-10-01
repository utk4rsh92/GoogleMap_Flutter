import 'package:demo/music/player.dart';
import 'package:demo/task_one.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
//AIzaSyD1dow6XGuNF7GpErtmo0uabjvYYDGURbk
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //use MaterialApp() widget like this
        home: Home() //create new widget class for this 'home' to
      // escape 'No MediaQuery widget found' error
    );
  }
}

//create new class for "home" property of MaterialApp()
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home:  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text('DreamWeaver',
          style: TextStyle(
            color: Colors.white,
          ),),
        ),
          body: Column(
            children: [
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskOne()),
                  );
                },
                child: Container(
                  //MediaQuery methods in use
                  margin: EdgeInsets.only(left: 30,top: 100,right: 30,bottom: 50),
                  height: 80.0,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Google Map",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                    ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF2DCDB0),
                        const Color(0xFFF2FD6C),
                      ],),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
               GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AudioPlayerClass()),
                  );
                },
                child: Container(
                  //MediaQuery methods in use
                  margin: EdgeInsets.only(left: 30,top: 100,right: 30,bottom: 50),
                  height: 80.0,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Audio Player",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                    ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      colors: [
                        //use '0xFF' before using custom color in flutter
                        const Color(0xFF2DCDB0),
                        const Color(0xFFF2FD6C),
                      ],),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),

            ],

          )
      ),
    );
  }
}

