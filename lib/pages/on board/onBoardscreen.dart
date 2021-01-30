 import 'dart:math';
 import '../home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../../routes/routes.dart';

class onboard extends StatefulWidget {
  static final style = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  @override
  _onboardState createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  bool slideIcon = true;
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;


  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Home()),
    );
  }

  final pages = [
    Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 800,
        child:Stack(
           children:[Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center
          ,
          children: <Widget>[
            Image(
               image: AssetImage('assets/images/med.gif',
               ),
              fit: BoxFit.fill,),
            SizedBox(height: 10,),
            Text("MEDITATION",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 28
              ),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("'Feelings come and go like clouds in a windy sky. Conscious breathing is my anchor'",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),),),

          ],
        ),
      ],),),
    ),
    Scaffold(
      backgroundColor:Colors.lightBlue,
      body: Container(
        width: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center
          ,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/music.gif',
              ),

              fit: BoxFit.fill
              ,
            ),
            SizedBox(height: 10,),

            Text("MUSIC",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 28
              ),),
            SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:Text("'Let music flow in your heart and enrich your soul.'",
            textAlign: TextAlign.center,
            style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18
              ),),),
            SizedBox(height: 10,),

          ],
        ),
      ),
    ),
    Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        width: 900,
        height: 900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/stories.gif',
              ),

              fit: BoxFit.fitHeight,
            ),
            SizedBox(height: 10,),
            Text("SLEEP STORIES",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 28
              ),),
            SizedBox(height: 10,),

               Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("'Sleep Stories, Restful Sleep, Easy Breathing, Healthy Body'",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18
              ),),),
            SizedBox(height: 10,),
          ],
        ),
      ),
    ),

    Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/drawing.gif',
              ),

              fit: BoxFit.contain,
              height: 500,
              width: 1000,),
            Text("DRAWING",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 28
              ),),
            SizedBox(height: 10,),
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child:Text("'Draw the Desire and Soul'",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18
              ),),),
            SizedBox(height: 10,),
          ],
        ),
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.transparent,
          type: MaterialType.circle,

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: pages,enableSlideIcon: slideIcon,slideIconWidget: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black12)
                ),
                    onPressed: () {
                      liquidController.jumpToPage(
                          page: liquidController.currentPage + 1);
                    },
                    child:
                    Text("Next",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,

                      ),),
                    color: Colors.white
                ),
              ),
            ),
              enableLoop: false,
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, _buildDot),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black12)
                ),
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(Routes.home);
                  },
                  child: Text("Get Started",
                    style: TextStyle(
                      color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,

                    ),),
                  color: Colors.white
                ),
              ),
            ),


          ],
    ),
    ),
    );
    }


    pageChangeCallback(int page) {
      setState(() {
        if (page == pages.length - 1) {
          slideIcon = false;
        } else {
          slideIcon = true;
        }
        page = page;
      });
    }
}