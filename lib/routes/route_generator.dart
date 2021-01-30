
import '../pages/category/Social stories/Social Stories.dart';
import 'package:sensoryscope/pages/Terms%20and%20condition/privacy_policy.dart';
import 'package:sensoryscope/pages/Terms%20and%20condition/terms%20and%20conditions.dart';
import 'package:sensoryscope/pages/category/Meditation/meditation_page.dart';
import 'package:sensoryscope/pages/category/calm/calm_screen.dart';
import 'package:sensoryscope/pages/category/isounds/isounds_page1.dart';
import '../pages/login/Auth/Login.dart';
import 'package:sensoryscope/pages/on%20board/onBoardscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/home/home.dart';
import '../pages/splash_page.dart';
import 'routes.dart';
import '../pages/musicplayer/musicplayerscreen.dart';
import '../pages/on board/Onboardnew.dart';
import 'package:sensoryscope/pages/category/sleepstories/sleepstories_screen.dart';
import '../pages/category/Drawing/flutter_draw.dart';

import 'package:sensoryscope/pages/category/isounds/isounds_page 2.dart';
import '../Music player/MusicPlayer.dart';
import '../pages/category/isounds/iSounds_page 3.dart';
import 'package:sensoryscope/Timer/timer.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => SplashPage());

      case Routes.onboardnew:
        return CupertinoPageRoute(builder: (_) => OnBoardingPage());


      case Routes.isoundcategory2:
        return CupertinoPageRoute(builder: (_) => isoundcategory());

      case Routes.SocialStories:
        return CupertinoPageRoute(builder: (_) => Socialstories());

      case Routes.home:
        return CupertinoPageRoute(builder: (_) => Home());

      case Routes.musicplayer:
        return CupertinoPageRoute(builder: (_) => Musicplayer2());

      case Routes.SocialStories:
        return CupertinoPageRoute(builder: (_) => Socialstories());

      case Routes.meditation:
        return CupertinoPageRoute(builder: (_) => Meditation());

      case Routes.calm:
        return CupertinoPageRoute(builder: (_) => Calm());

      case Routes.sleepstories:
        return CupertinoPageRoute(builder: (_) => SleepStories());

        case Routes.onboard:
        return CupertinoPageRoute(builder: (_) => onboard());

      case Routes.isoundcategory:
        return CupertinoPageRoute(builder: (_) => Isound());

      case Routes.drawing:
        return CupertinoPageRoute(builder: (_) => HomePages());

      case Routes.timer:
        return CupertinoPageRoute(builder: (_) =>  MyHomePage());

      case Routes.login:
        return CupertinoPageRoute(builder: (_) =>  Login());
      case Routes.tc:
        return CupertinoPageRoute(builder: (_) =>  Termsandcondition());
      case Routes.pp:
        return CupertinoPageRoute(builder: (_) =>  PrivacyPolicy());


      case Routes.Tag:
        return CupertinoPageRoute(builder: (_) =>  TagiSounds());




      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
