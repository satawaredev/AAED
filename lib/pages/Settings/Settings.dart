import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/pref_manager.dart';
import '../../utils/app_themes.dart';
import '../../utils/themebloc/theme_bloc.dart';
import 'Dark theme.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin<SettingsPage> {
  var _isDark = Prefs.getBool(Prefs.DARKTHEME, def: false);
  Color _color;

  @override
  void initState() {
    super.initState();
    _color = _isDark ? Colors.white.withOpacity(0.12) : Colors.grey[200];
  }

  @override
  Widget build(BuildContext context) {
    final name = ['Blue','Black','Red','Green','Orange','Purple','Yellow'];
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor:
        _isDark ? Colors.white.withOpacity(0.12) : Colors.grey[200],
        body:ListView.builder(itemCount: AppTheme.values.length,
          itemBuilder: (context, index){
            final itemAppTheme = AppTheme.values[index];
            return Card(
              color:appThemeData[itemAppTheme].primaryColor,
              child:ListTile(
                title:Text(name[index],
                  style: appThemeData[itemAppTheme].textTheme.body1,),
                onTap: (){
                   BlocProvider.of<ThemeBloc>(context)
                      .add(ThemeChanged(theme: itemAppTheme));

                },

              ),
            );
          },)
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

