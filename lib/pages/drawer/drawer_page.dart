import 'package:sensoryscope/pages/category/Meditation/meditation_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../routes/routes.dart';
import '../../utils/constants.dart';

class DrawerPage extends StatelessWidget {
  final Function onTap;
  final String name;

  const DrawerPage({Key key, @required this.onTap, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Scaffold(
        backgroundColor:Colors.black87,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:SafeArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 80),
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage('assets/images/logo.png'),
                                    height: 120,
                                    width: 120,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Sensoryscape ",style: TextStyle(color: Colors.amberAccent,fontWeight: FontWeight.bold,fontSize: 20),)
                                ],
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      _drawerItem(
                        text: 'Home',
                        onTap: () {
                          Navigator.pushNamed(context, Routes.home);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _drawerItem(
                        text: 'iSounds',
                        onTap: () {
                          Navigator.pushNamed(context, Routes.isoundcategory);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _drawerItem(
                        text: 'Meditation',
                        onTap: () {
                          Navigator.pushNamed(context, Routes.meditation);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _drawerItem(
                        text: 'Sleep stories',
                        onTap: () {
                          Navigator.pushNamed(context, Routes.sleepstories);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _drawerItem(
                        text: 'Be Calm',
                        onTap: () {
                          Navigator.pushNamed(context, Routes.calm);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _drawerItem(
                        text: 'Social Stories',
                        onTap: () {
                          Navigator.pushNamed(context, Routes.SocialStories);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _drawerItem(
                        text: 'Drawing',
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.drawing); //drawing page
                          /* _onAlertWithCustomContentPress(context);*/
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _drawerItem(
                        text: 'Timer',
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.timer); //timer page
                          /*  _onAlertWithCustomContentPressed(context);*/
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _drawerItem(
                        text: 'Privacy and policy',
                        onTap: () {
                          Navigator.pushNamed(context, Routes.pp); //timer page
                          /*  _onAlertWithCustomContentPressed(context);*/
                        },
                      ),

                    //  _drawerItem(
                     //   text: 'Logout',
                      //  onTap: () {
                       //   Navigator.pushNamed(context, Routes.login);
                     //  },
                    //  ),
                    ],
                  ),
                ),
              ),
              /*Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    Column(
    children: <Widget>[
    Text.rich(
    TextSpan(
    children: [
    TextSpan(
    text: 'In affiliation with AAED',
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    ),
    ),
    ],
    ),
    ),
    ]
    ),
    SizedBox(
    width: 10,
    ),
    Column(
    children: <Widget>[
    Image.asset(
    'assets/images/aaed logo.png',
    width: 30.0,
    height: 30.0,
    fit: BoxFit.fill,
    ),
    SizedBox(
    height: 5,
    ),

    ], ),

    ],),*/ //AAED
      ),),],),
      ),
    );
  }

  InkWell _drawerItem({
    @required String image,
    @required String text,
    @required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
        //this.onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 50,
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/$image.png',
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text.tr(),
              style: TextStyle(
                color:Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}

_onAlertWithCustomContentPressed(context) {
  Alert(
      context: context,
      title: "Under Development",
      content: Column(
        children: <Widget>[],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

_onAlertWithCustomContentPress(context) {
  Alert(
      context: context,
      title: "Under Development",
      content: Column(
        children: <Widget>[],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
