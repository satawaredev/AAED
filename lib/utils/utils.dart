import 'dart:io';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class Utils {
  static void showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey,
      String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new SimpleDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(2.0),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Please Wait....",
                  style: TextStyle(color: Colors.black),
                ),
                CircularProgressIndicator(),
              ],
            ),
          ],
        );
      },
    );
  }

/*  static String getDateFormat(DateTime dateTime, bool isToday) {
    String currentDateString =
        "${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}";
    String dateString =
        "${dateTime.day.toString()}-${dateTime.month.toString()}-${dateTime.year.toString()}";
    if (currentDateString == dateString && isToday) {
      return 'Today';
    }
    return dateString;
  }*/

/*  static String getDateFormatMillis(int dateTime, bool isToday) {
    DateTime ts = DateTime.fromMillisecondsSinceEpoch(dateTime);
    return getDateFormat(ts, isToday);
  }*/


}