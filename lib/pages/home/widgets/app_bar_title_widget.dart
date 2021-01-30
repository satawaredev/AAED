import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class AppBarTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
      'assets/images/logo.png',
          width: 35.0,
          height: 35.0,
      fit: BoxFit.fill,
       ),
        SizedBox(
          width:5,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Sensoryscape ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
