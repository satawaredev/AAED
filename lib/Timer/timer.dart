import 'package:flutter/material.dart';
import 'package:sensoryscope/Timer/pages/home.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
        child:Text('Timer',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 25),),),



      ),
    body: HomePage(title: 'F-Pomodoro')
    );
  }
}
