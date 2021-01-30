import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sensoryscope/pages/category/Meditation/meditation_page.dart';
import 'package:sensoryscope/pages/category/calm/calm_screen.dart';
import 'package:sensoryscope/pages/category/isounds/isounds_page 2.dart';
import 'package:sensoryscope/pages/category/sleepstories/sleepstories_screen.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sensoryscope/utils/constants.dart';
import '../../components/image_service.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../routes/routes.dart';
import '../../routes/route_generator.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:vibration/vibration.dart';


class Wallpapers extends StatelessWidget {
  const Wallpapers();
  _PatternVibrate() {
    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 200),
    );

    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 500),
    );

    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.mediumImpact();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: Scaffold(
      body: AnimationLimiter(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: 375),
            child: FadeInAnimation(
              child: FadeInAnimation(
                child: gridViewData(),
              ),
            ),
          );
        },
      ),
    ),
    ),
      ),
    );
  }
}


Widget gridViewData()
{
  final titles = [
    'iSounds',
    'Meditation',
    'Be Calm',
    /*'Task Box',*/
    'Drawing',
    'Sleep stories',
    'Timer',
    "Social Stories",
    "More item coming soon",

  ];
  final categories = [
    'assets/images/Itunes.png',
    'assets/images/meditate.png',
    'assets/images/calm down.png',
    /*'assets/images/Task.png',*/
    'assets/images/Drawing.jpg',
    /*'assets/images/meditate.png',*/
    'assets/images/sleep stories.png',
    'assets/images/Timer.png',
    'assets/images/Social Stories.jpg',
    'assets/images/Task.jpg',
    '',''
  ];
  final routes = [
    Routes.isoundcategory,
    Routes.meditation,
    Routes.calm,
    /* Routes.calm,*/
    Routes.drawing,
    /*Routes.isoundcategory,*/
    Routes.sleepstories,
    Routes.timer,
    Routes.SocialStories,
  ];

  final categoryId = ["7","1", "13",  "8",  "12", "9", "11","14"];

  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 4,
    itemCount: titles.length,
    itemBuilder: (BuildContext context, int index) {

      return Container(
        height: MediaQuery.of(context).size.width * 0.75,
        width: MediaQuery.of(context).size.width * 0.50,
        margin: EdgeInsets.fromLTRB(10,8,10,8),
        child: Stack(
          children: <Widget>[
            Neumorphic(style: NeumorphicStyle(
                shape: NeumorphicShape.flat,border: NeumorphicBorder(isEnabled: true,
          color: Color(0x33000000),
          width: 1,
        ),
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(19)),
                depth: -25,intensity: 1,surfaceIntensity: 1,
                lightSource: LightSource.bottomRight,oppositeShadowLightSource: true,
                color: Colors.grey
            ),
              child:InkWell(splashColor: Colors.black26,
              onTap: () {Vibration.vibrate(duration: 100);

                ConstantsHeading.mainHomeScreenCategoryId=categoryId[index];
                Navigator.of(context).pushNamed(routes[index]);
              },
              child: Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(categories[index]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 10, bottom: 30),
              child: Text(
                titles[index],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 10, bottom: 5),
            ),
          ],
        ),
      );
    },
    staggeredTileBuilder: (int index) =>
    new StaggeredTile.count(2, index.isEven ? 2.5 : 2),
    mainAxisSpacing: 2.0,
    crossAxisSpacing: 2.0,
  );
}