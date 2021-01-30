import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../routes/routes.dart';



class GeneralWidget extends StatefulWidget {
  final bool isDark;
  final Function onDarkPressed;

  const GeneralWidget(
      {Key key, @required this.isDark, @required this.onDarkPressed})
      : super(key: key);
  @override
  _GeneralWidgetState createState() => _GeneralWidgetState();
}

class _GeneralWidgetState extends State<GeneralWidget> {
  var _darkTheme;
  @override
  void initState() {
    super.initState();
    _darkTheme = widget.isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SwitchListTile(
          value: _darkTheme,
          onChanged: (_) {
            setState(() {
              _darkTheme = !_darkTheme;
              widget.onDarkPressed(_darkTheme);
            });
          },
          title: Text(
            'Dark theme',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

