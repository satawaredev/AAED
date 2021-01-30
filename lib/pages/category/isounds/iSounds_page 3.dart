import 'dart:convert';

import 'package:sensoryscope/model/GetAllSubCategoryTagModel.dart';
import 'package:sensoryscope/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sensoryscope/utils/constants.dart';
import '../../../components/image_service.dart';
import '../../../model/images_list_model.dart';
import '../../../pages/musicplayer/musicplayerscreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class TagiSounds extends StatefulWidget {
  @override
  _TagiSoundsState createState() => _TagiSoundsState();
}

class _TagiSoundsState extends State<TagiSounds> {
  List<Datum> myList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myList.clear();
    fetchAllSubCategoriesTag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
          child: Text(
            'iSounds',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (myList.isNotEmpty)
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    ConstantsHeading.iSOund3heading,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
              ),
            if (myList.isNotEmpty) gridList(context, myList),
            if (myList.isEmpty) progressBar()
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.amberAccent,
        items: <Widget>[
          Icon(Icons.home, size: 40),
          Icon(Icons.list, size: 40),
          Icon(Icons.music_note, size: 40),
          Icon(Icons.compare_arrows, size: 40),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }

  Future<GetAllSubCategoryTagModel> fetchAllSubCategoriesTag() async {
    var url = "https://sataware.net/aaed/AppServices/API/getTagsOfSubCategory";
    final response =
    await http.post(url, body: jsonEncode(<String, String>{
      'sub_category_id': ConstantsHeading.subCatIdSound3,
    }));

    if (response.statusCode == 200) {
      setState(() {
        var rssp = getAllSubCategoryTagModelFromJson(response.body);
        myList = rssp.data;
        print("mylist233 ${response.body}");
      });

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return GetAllSubCategories.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load sound3');
    }
  }

  Widget progressBar() {
    return Center(
      child: Container(
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
      ),
    );
  }
}

/*class TagiSounds extends StatelessWidget {
  const TagiSounds ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  }
}*/

Widget gridList(context, List<Datum> myList) {
  // final titles = ['angry lion','	lion roar', 'Asiatic lion', 'lion1','lion2',' lion3','lion4','lion5', 'lion6', 'lion7','lion roar',' lion roar'];
  // final categories =[ 'assets/images/lion.jpg','assets/images/lion.jpg','assets/images/lion.jpg','assets/images/lion.jpg','assets/images/lion.jpg','assets/images/lion.jpg','assets/images/lion.jpg','assets/images/lion.jpg','assets/images/lion.jpg','assets/images/lion.jpg'];
  /* return Container(
    // height: 700,
    child: FutureBuilder(
      future: getImages(type: 'travel'),
      builder: (BuildContext context, AsyncSnapshot<ImagesListModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
        return CircularProgressIndicator();
        else if (snapshot.data != null)
          return StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            itemCount: myList.length,
            itemBuilder: (BuildContext context, int index) {
              Result data = snapshot.data.results[index];
              return Container(
                height: MediaQuery.of(context).size.width * 0.75,
                width: MediaQuery.of(context).size.width * 0.50,
                margin: EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(myList[index].subCategoryIcon),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 50,
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(left: 10, bottom: 0.5),
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
                                    Navigator.pushNamed(
                                        context, Routes.musicplayer);
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
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
              );
            },
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(4, index.isEven ? 2 : 2),
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          );
        else
          return Container();
      },
    ),
  );*/

  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 4,
    itemCount: myList.length,
    itemBuilder: (BuildContext context, int index) {
      // Result data = snapshot.data.results[index];
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .width * 0.75,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.50,
        margin: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new NetworkImage(myList[index].tagFile),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 50,
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 10, bottom: 0.5),
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
                            ConstantsHeading.musicIcon =
                                myList[index].tagFile;
                            ConstantsHeading.musicSubCatId =
                                myList[index].subCategoryId;
                            print(
                                "musicsubcatID:  ${ConstantsHeading
                                    .musicSubCatId}");

                            ConstantsHeading.musicTitle =
                                myList[index].tagName;
                            Navigator.pushNamed(context, Routes.musicplayer);
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
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
            ),
          ],
        ),
      );
    },
    staggeredTileBuilder: (int index) =>
    new StaggeredTile.count(4, index.isEven ? 2 : 2),
    mainAxisSpacing: 5.0,
    crossAxisSpacing: 5.0,
  );
}
