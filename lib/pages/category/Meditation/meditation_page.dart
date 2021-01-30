import 'dart:convert';

import 'package:sensoryscope/Music%20player/MusicPlayer.dart';
import 'package:sensoryscope/model/GetAllSubCategories.dart';
import 'package:sensoryscope/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sensoryscope/utils/constants.dart';
import '../../../components/image_service.dart';
import '../../../model/images_list_model.dart';
import 'package:http/http.dart' as http;
import '../../../pages/musicplayer/musicplayerscreen.dart';

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class Meditation extends StatefulWidget {

  @override
  _MeditationState createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  // List<GetTagSubCatModel> myList = [];
  var myList = [];
  bool progress;
  var name = "",
      icon = "";

  Future<GetAllSubCategories> fetchAllSubCategories() async {
    /* final response = await http.post(
        "http://sataware.net/aaed/API/getSubCategoriesOfCategory",
        body: {"category_id": ConstantsHeading.subCategoryId});*/
    var url = "https://sataware.net/aaed/AppServices/API/getSubCategoriesOfCategory";
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'category_id': "1"
        }
          // body: {"sub_category_id": ConstantsHeading.subCategoryId}

        ));

   // print("34CategoryIdSound2 ${ConstantsHeading.subCategoryId}");

    if (response.statusCode == 200) {
      setState(() {
        progress = false;
        var rsp = getAllSubCategoriesFromJson(response.body);
        myList = rsp.data;

        // print("mylist 34 ${myList[0].categoryId}  ${myList[0].categoryId}");
      });

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return GetAllSubCategories.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myList.clear();
    fetchAllSubCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        centerTitle: true,
        title: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
          child:Text(
            'Meditation',
            style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 25),
          ),),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,size: 35,
            color: Colors.black,
          ),
        ),
      ),
        body: SingleChildScrollView(

              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Container(
              child:Stack(
        children: <Widget>[
              Container(
                height: 250,

                decoration: BoxDecoration(
                  image:DecorationImage(
                    image: AssetImage('assets/images/meditate.png'),
                    fit:BoxFit.fitWidth,

                    colorFilter:
                    ColorFilter.mode(Colors.black.withOpacity(0.5),
                        BlendMode.colorBurn),
                  ),
                ),
              ),
                      Container(

            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 95),
            child: Text(
              'Meditation',
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize:40),
            ),
          ),
  ],
        ),),
                    if (myList.isNotEmpty) girdlist(context, myList)
    ],),



),

    );

  }
}



 Widget girdlist(context, List myList) {
    /*final titles = [
    'i tunes',
    'Sleep Stories',
    'Meditation',
    'Calm Down',
    'Task Box Activities',
    ' Drawing',
    'Token Board',
    'Timer',
    "More item coming soon",
    ''
  ];
  final subtitles = [
    'Lion',
    'Horse',
    'Wolf',
    'Fox',
    "Tiger",
    'Elephant',
    'Zebra',
    "",
    '',
    'lion'
  ];
  final categories = [
    'assets/images/lion.jpg',
    'assets/images/horse.jpg',
    'assets/images/wolf.jpg',
    'assets/images/Fox.jpg',
    'assets/images/Tiger.jpg',
    'assets/images/elephant.png',
    'assets/images/Fox.jpg',
    'assets/images/wolf.jpg',
    'assets/images/horse.jpg',
    'assets/images/lion.jpg'
  ];*/
    return Container(
      // height: 700,
      child: FutureBuilder(
        future: getImages(type: 'travel'),
        builder: (BuildContext context,
            AsyncSnapshot<ImagesListModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(),
                    height: 40.0,
                    width: 40.0,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        "Loading your tracks...",
                        style: TextStyle(fontSize: 18),
                      ))
                ],
              ),
            );
          else if (snapshot.data != null)
            return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              itemCount: myList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Musicplayer2(catId: myList[index].categoryId,sublist: myList,index: index,),));},
                  child:Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.50,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(myList[index].subCategoryImage),
                            // image: NetworkImage(icon),

                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 45,
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.only(left: 10, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(11),
                                      bottomRight: Radius.circular(11)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.play_arrow,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      /*ConstantsHeading.iSOund3heading =
                                          myList[index].subCatTagName;*/
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Musicplayer2(catId: myList[index].categoryId,sublist: myList,index: index,),));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 20, bottom: 5),
                        child: Text(
                          myList[index].subCategoryName,
                          // name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),);
              },
              staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 2 : 2.6),
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
            );
          else
            return Container();
        },
      ),
    );
  }


///Meditation Screen

