import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sensoryscope/model/GetAllSubCategories.dart';
import '../../../utils/constants.dart';
import '../isounds/Animation/model.dart';
import 'package:sensoryscope/routes/routes.dart';
import 'package:http/http.dart' as http;

class Isound extends StatefulWidget {
  int index = 0;

  @override
  _IsoundState createState() => _IsoundState();
}

class _IsoundState extends State<Isound> {
  // List<Datum> myList = List<Datum>();

  List<Datum> myList = [];
  bool progress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myList.clear();
    progress = true;
    fetchAllSubCategories();
  }

  Future<GetAllSubCategories> fetchAllSubCategories() async {
/*    final response =
        await http.get("http://sataware.net/aaed/API/getAllSubCategories");*/
    var url =
        "https://sataware.net/aaed/AppServices/API/getSubCategoriesOfCategory";
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'category_id': "7"
      }),
    );

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
      setState(() {
        progress = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    String backgroundImage;
    if (myList.length > 0) {
      backgroundImage = myList[widget.index].subCategoryImage;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
            child: Text(
              'iSounds',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
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
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            if (progress == true)
              Container(
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
            if (myList.length > 0)
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                  ],
                ),
              ),
            Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (myList.length > 0)
                  BackgroundGradientImage(
                    image: Image.network(
                      backgroundImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (myList.length > 0)
                  SafeArea(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Padding(padding: EdgeInsets.symmetric(vertical: 90.0)),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          myList[widget.index].subCategoryName,
                          // "test222",
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          iconSize: 80,
                          color: Colors.white,
                          onPressed: () {
                            ConstantsHeading.subCategoryId =
                                myList[widget.index].id;
                            ConstantsHeading.subCategoryName =
                                myList[widget.index].subCategoryName;
                            ConstantsHeading.subCategoryIcon =
                                myList[widget.index].subCategoryImage;

                            Navigator.pushNamed(
                                context, Routes.isoundcategory2);
                          },
                        ),
                          Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: myList.length,
                                  itemBuilder: (context, index) {
                                    return MovieCard(
                                      title: myList[index].subCategoryName,
                                      images: myList[index].subCategoryImage,
                                      // active: index == widget.index ? true : false,
                                      callBack: () {
                                        setState(() {
                                          widget.index = index;
                                        });
                                      },
                                      active: true,
                                    );
                                  })),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ));
  }
}

class MovieCard extends StatelessWidget {
  final String images;

  final String title;

  final Function callBack;

  final bool active;

  MovieCard(
      {@required this.title,
      @required this.images,
      @required this.callBack,
      @required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: callBack,
            child: SizedBox(
              width: active
                  ? MediaQuery.of(context).size.width / 2.5
                  : MediaQuery.of(context).size.width / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                    width: 150,
                    height: 200,
                    child: Image.network(images, fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        Text(active ? title : '',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ],
    );
  }
}

class BackgroundGradientImage extends StatelessWidget {
  final Image image;

  BackgroundGradientImage({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.0, 1],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.black26,
            Colors.black,
          ],
        ),
      ),
      child: image,
    );
  }
}
