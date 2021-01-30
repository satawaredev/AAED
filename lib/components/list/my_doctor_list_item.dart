import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../../model/doctor.dart';

class VisitedDoctorListItem extends StatelessWidget {
  final Doctor doctor;

  const VisitedDoctorListItem({Key key, @required this.doctor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      Container(
      width: 180,
      height: 200,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0x0c000000),
              offset: Offset(0, 5),
              blurRadius: 5,
              spreadRadius: 0),
          BoxShadow(
              color: Color(0x0c000000),
              offset: Offset(0, -5),
              blurRadius: 5,
              spreadRadius: 0),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
        GFAvatar(
          radius: 70,
          shape:GFAvatarShape.standard,
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage(doctor.avatar),
      ),
      SizedBox(
      height: 5,
    ),
    Text(
    doctor.name,
    style: TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    ),
    Text(
    doctor.speciality,
    style: TextStyle(
    color: Colors.grey,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
    )
    ],
    ),
    ), ], );
  }
}
