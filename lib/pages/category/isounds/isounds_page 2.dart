import 'dart:convert';

import 'package:sensoryscope/Music%20player/MusicPlayer.dart';
import 'package:sensoryscope/model/GetTagSubCatModel.dart';
import 'package:sensoryscope/model/TagSubCatModel.dart';
import 'package:sensoryscope/pages/category/isounds/isounds_page1.dart';
import 'package:sensoryscope/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sensoryscope/utils/constants.dart';
import '../../../components/image_service.dart';
import '../../../model/images_list_model.dart';
import '../../../pages/musicplayer/musicplayerscreen.dart';
import 'package:http/http.dart' as http;

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class isoundcategory extends StatefulWidget {
  @override
  _isoundcategoryState createState() => _isoundcategoryState();
}

class _isoundcategoryState extends State<isoundcategory> {
  // List<GetTagSubCatModel> myList = [];
  List<Datum> myList = [];
  var name = "",
      icon = "";

  Future<TagSubCatModel> fetchAllSubCategories() async {
    /* final response = await http.post(
        "http://sataware.net/aaed/API/getSubCategoriesOfCategory",
        body: {"category_id": ConstantsHeading.subCategoryId});*/
    var url = "https://sataware.net/aaed/AppServices/API/getTagsOfSubCategory";
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          'sub_category_id': ConstantsHeading.subCategoryId,
        }
          // body: {"sub_category_id": ConstantsHeading.subCategoryId}

        ));

        print("${url}  34CategoryIdSound2 ${ConstantsHeading.subCategoryId}");

    if (response.statusCode == 200) {
      setState(() {
        // var rsssp = tagSubCatModelFromJson(response.body);

        var rsp = tagSubCatModelFromJson(response.body);
        myList=rsp.data;
        name = rsp.data[0].tagName;
        icon = rsp.data[0].tagName;

        // icon = rsp.subCatTagIcon.toString();
        print("mylist22 ${response.body} ");
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
        backgroundColor: Colors.white,
        centerTitle: true,
        // title: Text('Animal Sounds'),
        title: Text(ConstantsHeading.subCategoryName),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // image: AssetImage('assets/images/elephant.png'),
                        image: NetworkImage(ConstantsHeading.subCategoryIcon),
                        fit: BoxFit.fitWidth,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 95),
                    child: Text(
                      // 'ANIMAL SOUNDS',
                      ConstantsHeading.subCategoryName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 31),
                    ),
                  ),
                ],
              ),
            ),
            if (myList.isNotEmpty) girdlist(context, myList)
            // if (name.isNotEmpty) girdlist(context, myList)

          ],
        ),
      ),
    );
  }

  Widget girdlist(context, List<Datum> myList) {
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
                return InkWell(onTap: (){
                  ConstantsHeading.musicIcon =
                      myList[index].tagFile;
                  ConstantsHeading.musicSubCatId =
                      myList[index].id;
                  print(
                      "musicsubcatID:  ${ConstantsHeading
                          .musicSubCatId}");

                  ConstantsHeading.musicTitle =
                      myList[index].tagName;
                  /**----------------------ASMOBISOFT START----------------***/
                  print("DATA ${myList[index].subCategoryId}");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Musicplayer2(catId: myList[index].subCategoryId,list: myList,index: index,),));
                },
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
                            image: NetworkImage(myList[index].tagFile),
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
                                      ConstantsHeading.musicIcon =
                                          myList[index].tagFile;
                                      ConstantsHeading.musicSubCatId =
                                          myList[index].id;
                                      print(
                                          "musicsubcatID:  ${ConstantsHeading
                                              .musicSubCatId}");

                                      ConstantsHeading.musicTitle =
                                          myList[index].tagName;
                                     /**----------------------ASMOBISOFT START----------------***/
                                      print("DATA ${myList[index].subCategoryId}");
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Musicplayer2(catId: myList[index].subCategoryId,list: myList,index: index,),));
                                      /**----------------------ASMOBISOFT END----------------***/
                                     // Navigator.pushNamed(context, Routes.musicplayer);
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
                          myList[index].tagName,
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

}

/*
class isoundcategory extends StatelessWidget {


  const isoundcategory({Key key}) : super(key: key);

   // List<GetTagSubCatModel> myList = [];



  Future<GetTagSubCatModel> fetchAllSubCategories() async {
    final response =
    await http.get("http://sataware.net/aaed/API/getAllSubCategories");

    if (response.statusCode == 200) {
      setState(() {
        myList = getAllSubCategoriesOfCategoryFromJson(response.body);
        print("mylist $myList");
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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Animal Sounds'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/elephant.png'),
                        fit: BoxFit.fitWidth,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 95),
                    child: Text(
                      'ANIMAL SOUNDS',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 31),
                    ),
                  ),
                ],
              ),
            ),
            girdlist(context)
          ],
        ),
      ),
    );
  }
}
*/

