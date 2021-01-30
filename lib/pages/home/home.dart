import 'package:sensoryscope/data/pref_manager.dart';
import 'package:sensoryscope/pages/Settings/custom%20theme.dart';
import 'package:sensoryscope/pages/category/calm/calm_screen.dart';
import 'package:sensoryscope/pages/category/isounds/isounds_page1.dart';
import 'package:sensoryscope/utils/app_themes.dart';
import 'package:sensoryscope/utils/themebloc/theme_bloc.dart';
import '../FAQ/Faq list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../routes/routes.dart';
import '../category/Drawing/drawing.dart';
import '../../utils/constants.dart';
import '../drawer/drawer_page.dart';
import '../Settings/Settings.dart';
import 'home_page.dart';
import 'widgets/widgets.dart';
import '../category/Meditation/meditation_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _isDark = Prefs.getBool(Prefs.DARKTHEME, def: false);
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  Color _color;

  bool isDrawerOpen = false;

  int _selectedIndex = 0;
  int pageIndex =0;

  static PageController _pageController;


  @override
  void initState() {
    super.initState();
    getUserName();
    _color = _isDark ? Colors.white.withOpacity(0.12) : Colors.grey[200];
    _pageController = PageController(keepPage: true,
      initialPage: _selectedIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _selectPage(int index) {
    if (_pageController.hasClients) _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    final _pages = [
      HomePage(),
      Drawing1(),FAQ1()
    ];
    return Stack(
      children: <Widget>[
        DrawerPage(
          name: name,
          onTap: () {
            setState(
              () {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              },
            );
          },
        ),
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor)
            ..rotateY(isDrawerOpen ? -0.5 : 0),
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
            child: Scaffold(
              backgroundColor:
              _isDark ? Colors.white.withOpacity(0.12) : Colors.grey[200],
              appBar: AppBar(
                leading: isDrawerOpen
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(
                            () {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            },
                          );
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            xOffset = size.width - size.width / 4;
                            yOffset = size.height * 0.1;
                            scaleFactor = 0.8;
                            isDrawerOpen = true;
                          });
                        },
                      ),
                title: AppBarTitleWidget(),centerTitle: true,
                actions: <Widget>[
                     IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.tc);
                          },
                          icon: Icon(
                            Icons.help_outline,
                          ),
                        ),
                ],
              ),
              body: PageView(allowImplicitScrolling: false,reverse: false,pageSnapping: false,
                physics: NeverScrollableScrollPhysics()
              ,  controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: _pages,
              ),
              bottomNavigationBar: CurvedNavigationBar(

                backgroundColor: Colors.amberAccent,
                items: <Widget>[
                  /*GeneralWidget(
                    isDark: _isDark,
                    onDarkPressed: (darkTheme) {
                      setState(() {
                        _isDark = darkTheme;
                        Prefs.setBool(Prefs.DARKTHEME, darkTheme);
                        context.bloc<ThemeBloc>().add(ThemeChanged(
                            theme: darkTheme
                                ? AppTheme.DarkTheme
                                : AppTheme.LightTheme));
                        _color = _isDark
                            ? Colors.white.withOpacity(0.12)
                            : Colors.grey[200];
                      });
                    },
                  ),*/
                  Icon(Icons.home, size: 40),
                  Icon(Icons.brush, size: 40),
                  Icon(Icons.info_outline, size: 40),                ],
                onTap: (int Index) {
                  setState(() {
                    _selectPage(Index);
                  });
                  //Handle button tap
                },
              ),
    ),
    ),
    ),

],
    );
  }

  String name;
  void getUserName() async{
    setState(() {
      name = Prefs.getString("username");
    });
  }
}
