library flutter_draw;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../data/data.dart';
import '../../../model/gradient.dart';
import '../Drawing/painter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../routes/routes.dart';

/// Draw Class.
PainterController controller = new PainterController();

// this is for painter

/// GLobal Variables/Constants..
PainterController _controller;

setPaintController() {
  // this is for painter
  _controller = _newController();
}

File imageFile;

var rng = new Random();

// this is for painter
PainterController _newController() {
  controller.thickness = penThickness;
  controller.drawColor = selectedColor;
  controller.backgroundColor = Colors.white;
  return controller;
}

final GlobalKey globalKey = new GlobalKey();

bool selectingPenThickness = false;
bool selectingEraserThickness = false;
double penThickness = 5.0;
double eraserThickness = 5.0;


ByteData imagePngBytes;
String fileName;

Future<File> takeScreenshotAndSave() async {
  RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
  ui.Image image = await boundary.toImage();
  final directory = (await getApplicationDocumentsDirectory()).path;
  ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData.buffer.asUint8List();
  print(pngBytes);

  imagePngBytes = byteData;

  String imageName = randomAlphaNumeric(200);
  fileName = imageName;
  File imgFile = File('$directory/${rng.nextInt(200)}.png');

  await _askPermission();
  final result =
  await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes));
  print(result);
  imgFile.writeAsBytes(pngBytes);
  return imgFile;
}

_askPermission() async {
  if (Platform.isIOS) {
    /*Map<PermissionGroup, PermissionStatus> permissions =
    */await PermissionHandler().requestPermissions([PermissionGroup.photos]);
  } else {
    /*PermissionStatus permission =*/ await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
  }
}

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  List<GradientModel> gradients = new List<GradientModel>();

  @override
  void initState() {
    super.initState();
    gradients = getGradients();
    setPaintController();
    _askPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }
  var pathSave;


  Widget paintScreen() {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
          height: MediaQuery.of(context).size.height - 200,
          child: Painter(_controller)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:  InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back,color: Colors.black,size: 30,)),
        ),
        title: Text(
          "Draw",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[

        ],
      ),
      backgroundColor: Colors.grey,
      body: Column(
        children: <Widget>[
          ColorsList(gradients),
          paintScreen()
        ],
      ),
      bottomSheet: BottomToolBar(), // drawing



    );
  }
}

class ColorsList extends StatefulWidget {
  final List<GradientModel> gradients;
  ColorsList(this.gradients);

  @override
  _ColorsListState createState() => _ColorsListState();
}

class _ColorsListState extends State<ColorsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          itemCount: widget.gradients.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = widget.gradients[index].topColor;
                          setPaintController();
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: widget.gradients[index].topColor,
                        child: selectedColor == widget.gradients[index].topColor
                            ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                            : Container(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = widget.gradients[index].bottomColor;
                          setPaintController();
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: widget.gradients[index].bottomColor,
                        child: selectedColor == widget.gradients[index].bottomColor
                            ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                            : Container(),
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}

class BottomToolBar extends StatefulWidget {
  @override
  _BottomToolBarState createState() => _BottomToolBarState();
}

class _BottomToolBarState extends State<BottomToolBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isIOS ? 75 : 55,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          selectingEraserThickness ? Container(
            height: 50,
            color: Colors.white,
            child: Slider(
              value: eraserThickness,
              onChanged: (thickness) {
                setState(() {
                  eraserThickness = thickness;
                  setPaintController();
                });
              },
              onChangeEnd: (double) {
                setState(() {
                  selectingEraserThickness = false;
                });
              },
              min: 3.0,
              max: 25.0,
            ),
          ) : selectingPenThickness
              ? Container(
            height: Platform.isIOS ? 70 : 50,
            color: Colors.white,
            child: Slider(
              activeColor: Colors.amberAccent,
              value: penThickness,
              onChanged: (thickness) {
                setState(() {
                  penThickness = thickness;
                  setPaintController();
                });
              },
              onChangeEnd: (double) {
                setState(() {
                  selectingPenThickness = false;
                });
              },
              min: 3.0,
              max: 25.0,
            ),
          )
              : Container(
            height: Platform.isIOS ? 70 : 50,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    confirmDialog1(context);
                  },
                  child: Container(
                    height: Platform.isIOS ? 70 : 50,
                    color: Colors.amberAccent,
                    width: MediaQuery.of(context).size.width / 5 - 1,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 1,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (selectingPenThickness) {
                        selectingPenThickness = false;
                      } else {
                        selectingPenThickness = true;
                      }
                    });
                  },
                  child: Container(
                    height: Platform.isIOS ? 70 : 50,
                    color: Colors.amberAccent,
                    width: MediaQuery.of(context).size.width / 5 - 1,
                    child: Icon(
                      Icons.brush,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 1,
                ),
                InkWell(
                  onTap: () {
                    setState(() {});
                    selectedColor = Colors.white;
                    setPaintController();
                  },
                  child: Container(
                    height: Platform.isIOS ? 70 : 50,
                    color: Colors.amberAccent,
                    width: MediaQuery.of(context).size.width / 5 - 1,
                    child:  SvgPicture.asset(
                     'assets/images/eraser .svg',
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 1,
                ),
                InkWell(
                  onTap: () async {
                    takeScreenshotAndSave();
                    _onAlertWithCustomContentPressed(context);
                  },
                  child: Container(
                    height: Platform.isIOS ? 70 : 50,
                    color: Colors.amberAccent,
                    width: MediaQuery.of(context).size.width / 5 - 1,
                    child: Icon(
                      Icons.save,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 1,
                ),
                InkWell(
                  onTap: _controller.undo,
                  child: Container(
                    height: Platform.isIOS ? 70 : 50,
                    color: Colors.amberAccent,
                    width: MediaQuery.of(context).size.width / 5 ,
                    child: Icon(
                      Icons.undo,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


_onAlertWithCustomContentPressed(context) {
  Alert (
      context: context,
      image: Image(
        image: AssetImage('assets/images/saved.gif'),
      ),

      title: "Do you want to save the drawing?",
      content: Column(
        children: <Widget>[

        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.amberAccent,
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),DialogButton(
          color: Colors.amberAccent,
          onPressed: () => Navigator.pop(context),
          child: Text(
            "No",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        )
      ]).show();
}

Future<bool> confirmDialog1(BuildContext context) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/new.gif'),
              ),
              Text('Are you sure you want to create new document?'),
              SizedBox(
                height: 8,
              ),
              Text(
                'it will delete the current document',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 30,
              ),

              Row(children:[
                FlatButton(
                  child: const Text('Delete and Create New',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    controller.clear();
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: const Text('NO',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],), ],
          ),
        );
      });
}
_onAlertWithCustomContentPress(context) {
  Alert(
    closeIcon: Icon(
    Icons.close,
  ),
    onWillPopActive: true,
      context: context,

      title: "Under Development",
      content: Column(
        children: <Widget>[
        ],
      ),
      ).show();
}