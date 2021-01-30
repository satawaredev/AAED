import 'package:sensoryscope/pages/category/isounds/isounds_page 2.dart';
import 'package:sensoryscope/pages/category/isounds/isounds_page1.dart';
import 'package:sensoryscope/pages/category/sleepstories/sleepstories_screen.dart';
import 'package:sensoryscope/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sensoryscope/pages/category/Meditation/meditation_page.dart';
import '../../pages/MainMenu/wallpapers.dart';


import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
 // final _kTabTextStyle = TextStyle(
 //   color: Colors.red,
//    fontSize: 12,
  //  fontWeight: FontWeight.w400,
 //   fontStyle: FontStyle.normal,
//  );

//  final _kTabPages = [
//    Wallpapers(),
 //   Isound(),
//  ];

  @override
  Widget build(BuildContext context) {
    print('Enter profile');
    super.build(context);
    final size = MediaQuery.of(context).size;

  //  var _kTabs = [
 //     Tab(
 //       text: 'Discover'.tr(),
 //     ),
  //    Tab(
 //       text: 'Activities'.tr(),
  //    ),

 //   ];

    return Column(
      children: <Widget>[

        SizedBox(
          height: 15,
        ),
        Expanded(
          child:Wallpapers(),
    /* DefaultTabController(
            length: _kTabs.length,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,

                  child: TabBar(
                    indicatorColor: Colors.red,
                    labelStyle: _kTabTextStyle,
                    unselectedLabelStyle:
                    _kTabTextStyle.copyWith(color: Colors.grey),
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    tabs: _kTabs,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: _kTabPages,
                  ),
                ),
              ],
            ),
          ),*/
        ), ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
