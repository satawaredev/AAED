import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensoryscope/Music%20player/MusicModel.dart';
import 'package:sensoryscope/utils/constants.dart';
import '../Music player/sizeconfig.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sensoryscope/model/TagSubCatModel.dart' as data;
import 'package:audio_manager/audio_manager.dart';
import 'package:music_player/music_player.dart' as mp;
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:sensoryscope/model/GetAllSubCategories.dart' as subData;


class Musicplayer2 extends StatelessWidget {
  // This widget is the root of your application.
  String catId;
  int index;
  final List<data.Datum> list;
  final List<subData.Datum> sublist;
  Musicplayer2({this.catId,this.list,this.index,this.sublist});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        Responsive().init(constraints, orientation);
        return Scaffold(
          body: MusicPlayer(catId: catId,index: index,list: list,sublist: sublist,),
        );
      });
    });
  }
}

enum PlayerState { stopped, playing, paused }

class MusicPlayer extends StatefulWidget {
  String catId;
  int index;
  List<data.Datum> list;
  final List<subData.Datum> sublist;

  MusicPlayer({this.catId,this.list,this.index,this.sublist});
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  // bottom sheet controller
  // SolidController _sheetController = SolidController();

//  https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand60.wav
  String kUrl =
      "https://www.mediacollege.com/downloads/sound-effects/nature/forest/rainforest-ambient.mp3";

//      "https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_5MG.mp3";

  Duration duration;
  Duration position;

  ap.AudioPlayer audioPlayer;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;

  get isPaused => playerState == PlayerState.paused;

  bool isPlayingIcon; // to chnange the icon play/pause
  bool isSheetOpen;
  String totalDuration = "0:0";
  String currentDuration = "0:0";

  // double _lowerValue = 100.0;
  double _lowerValue = 0.0;

  double _upperValue;
  bool isPlayingFlag = false;
  IconData faIcon = FontAwesomeIcons.pause;
  double firstOffset = 5.0;
  double secondOffset = -5.0;

  List<Datum> myList = [];

  var initialIndex = 0;

  bool musicIsPlaying;

/*****----------ASMOBISOFT START-------****/

 // AudioPlayer audioPlayer;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  Duration _slider = new Duration(seconds: 0);
  double durationvalue;
  bool issongplaying = true;
  double _sliderVolume;
  String _error;
  num curIndex = 0;
 // PlayMode playMode = AudioManager.instance.playMode;
  mp.MusicPlayer musicPlayer;
  @override
  void dispose() {
    print("IN disspose");
    /*AudioManager.instance.stop();
    AudioManager.instance.release();*/
    audioPlayer.stop();
    audioPlayer.release();

    super.dispose();
  }

  String _platformVersion = 'Unknown';
  Future<void> initPlatformState() async {
    musicPlayer = mp.MusicPlayer();
    String platformVersion;
    try {
      platformVersion = await AudioManager.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  /*****----------ASMOBISOFT START-------****/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initPlatformState();
    musicIsPlaying = false;
    audioPlayer = new ap.AudioPlayer();
    audioPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    audioPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
    ind = widget.index;

    if(widget.list!=null)
      {
        if(widget.list[ind].musicData.length>0)
         fetchMusic(widget.list[ind].musicData[0].tagId);
      }
    else
      {
        if(widget.sublist[ind].musicData.length>0)
          fetchSubMusic(widget.sublist[ind].musicData[0].subCategoryId);
      }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: stopPlayer,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0XFF2e2e2e),
        body: Stack(
          alignment: Alignment.center,
          children: [
            if (myList.isEmpty)
              Center(
                child: widget.list!=null?Text(
                  widget.list[ind].musicData.length>0?  "Loading Track...":"No track found",
                  style: TextStyle(
                    fontSize: 3.6 * Responsive.textMultiplier,
                    color: Colors.white70,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ):Text(
                  widget.sublist[ind].musicData.length>0?  "Loading Track...":"No track found",
                  style: TextStyle(
                    fontSize: 3.6 * Responsive.textMultiplier,
                    color: Colors.white70,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (myList.isNotEmpty)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.topCenter,
//            colors: [Color(0XFF24242c), Color(0XFF2e2e2e)],
//          ),
//        ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 5 * Responsive.heightMultiplier,
                          horizontal: 6 * Responsive.widthMultiplier),
                      child: Row(
                        children: <Widget>[
                          _neuButton(Icons.arrow_back),
                          Spacer(),
                          Text(
                            "PLAYING NOW",
                            style: TextStyle(
                              color: Colors.white38,
                              letterSpacing: 0.25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          _neuButton(Icons.menu),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.5 * Responsive.heightMultiplier,
                    ),
                    Container(
                      height: 80 * Responsive.imageSizeMultiplier,
                      width: 80 * Responsive.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0XFF212121),
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0XFF1c1c1c),
                            offset: Offset(15.0, 15.0),
                            blurRadius: 22.0,
                          ),
                          new BoxShadow(
                            color: Color(0XFF404040),
                            offset: Offset(-15.0, -15.0),
                            blurRadius: 22.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    // new NetworkImage(ConstantsHeading.musicIcon)),

                                    new NetworkImage(
                                        myList[initialIndex].musicImage)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4 * Responsive.heightMultiplier,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            // text: "Horse",
                            text: myList[initialIndex].musicName,
                            // text: ConstantsHeading.musicTitle,

                            style: TextStyle(
                              fontSize: 3.6 * Responsive.textMultiplier,
                              color: Colors.white70,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.5 * Responsive.heightMultiplier,
                    ),
                    Text(
                      // "Animal sounds",choslo
                      // myList[0].musicTitle,
                      myList[initialIndex].musicType,
                      // ConstantsHeading.musicTitle,

                      style: TextStyle(
                        fontSize: 1.6 * Responsive.textMultiplier,
                        color: Colors.white54,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 2 * Responsive.heightMultiplier,
                    ),
                   /* Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * Responsive.widthMultiplier),
                      child: Row(
                        children: <Widget>[
                          *//*  Text(
                          (_lowerValue / 60).toStringAsFixed(0) +
                              ":" +
                              ":" +
                              (_lowerValue % 60).toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),*//*
                          Text(
                            // myList[0].musicDuration,
                            // "2:34",
                            // "0.00",
                            currentDuration,
                            style: TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                          Spacer(),
                          Text(
                            // "4:57",
                            totalDuration,
                            style: TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    /*FlutterSlider(
                      values: [_lowerValue, _upperValue],
                      max: 297,
                      min: 0,
                      tooltip: FlutterSliderTooltip(
                          textStyle:
                              TextStyle(fontSize: 13, color: Colors.transparent),
                          boxStyle: FlutterSliderTooltipBox(
                              decoration:
                                  BoxDecoration(color: Colors.transparent))),
                      trackBar: FlutterSliderTrackBar(
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12,
                          border: Border.all(width: 10, color: Colors.black87),
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0XFF171717),
                              offset: Offset(-3.0, -3.0),
                              blurRadius: 3.0,
                            ),
                            new BoxShadow(
                              color: Color(0XFF404040),
                              offset: Offset(1.0, 1.0),
                        musicPlayer      blurRadius: 0.5,
                            ),
                          ],
                        ),
                        activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0XFF171717),
                              offset: Offset(-3.0, -3.0),
                              blurRadius: 3.0,
                            ),
                            new BoxShadow(
                              color: Color(0XFF404040),
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                            ),
                          ],
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.lightBlueAccent]),
                        ),
                      ),
                      handler: FlutterSliderHandler(
                        disabled: true,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF1c1c1c),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0XFF212121),
                              boxShadow: [
                                new BoxShadow(
                                  color: Color(0XFF1c1c1c),
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 5.0,
                                ),
                                new BoxShadow(
                                  color: Color(0XFF404040),
                                  offset: Offset(-3.0, -3.0),
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Container(
//                      height: 1 * Responsive.heightMultiplier,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Color(0XFF1c1c1c),
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 10.0,
                                  ),
                                  new BoxShadow(
                                    color: Color(0XFF404040),
                                    offset: Offset(-5.0, -5.0),
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          _lowerValue = lowerValue;
                          _upperValue = upperValue;

                          print("slider value:: $_lowerValue  $_upperValue");
                        });
                      },

                    ),
                    SizedBox(
                      height: 2 * Responsive.heightMultiplier,
                    ),*/
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12 * Responsive.widthMultiplier),

                      child:/* Row(
                        children: <Widget>[
                          *//*_neuControls(FontAwesomeIcons.backward,"previous"),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                // if (isPlaying == true) {
                                *//**//*if (musicIsPlaying == true) {
                                  setState(() {
                                    faIcon = FontAwesomeIcons.play;
                                    // isPlayingFlag = !isPlaying;
                                    isPlayingFlag = !musicIsPlaying;

                                    firstOffset = -5.0;
                                    secondOffset = -5.0;
                                  });
                                } else if (musicIsPlaying == false) {
                                  setState(() {
                                    faIcon = FontAwesomeIcons.pause;
                                    // isPlayingFlag = !isPlaying;
                                    isPlayingFlag = !musicIsPlaying;

                                    firstOffset = 5.0;
                                    secondOffset = 5.0;
                                  });
                                }*//**//*


                                *//**//*----------ASMOBISOFT STRAT------*//**//*
                                if (isPlayingFlag == true) {
                                  setState(() {
                                    faIcon = FontAwesomeIcons.play;
                                    // isPlayingFlag = !isPlaying;
                                    isPlayingFlag = false;
                                    audioPlayer.pause();
                                    firstOffset = -5.0;
                                    secondOffset = -5.0;

                                  });
                                } else if (isPlayingFlag == false) {
                                  setState(() {
                                    faIcon = FontAwesomeIcons.pause;
                                    // isPlayingFlag = !isPlaying;
                                    isPlayingFlag = true;

                                    firstOffset = 5.0;
                                    secondOffset = 5.0;
                                  });

                                }
                                *//**//*----------ASMOBISOFT END------*//**//*
                              },
                              child: _neuPausePlay(faIcon)),
                          Spacer(),
                          _neuControls(FontAwesomeIcons.forward,"next"),*//*
                          bottomPanel()
                        ],
                      )*/bottomPanel(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget bottomPanel() {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 1),
        child: songProgress(context),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            /*IconButton(
                icon: getPlayModeIcon(playMode),
                onPressed: () {
                  playMode = AudioManager.instance.nextMode();
                  setState(() {});
                }),*/
            /*IconButton(
                iconSize: 36,
                icon: Icon(
                  Icons.skip_previous,
                  color: Colors.black,
                ),
                onPressed: () => AudioManager.instance.previous()),*/
            _neuControls(FontAwesomeIcons.backward, "previous"),
            Spacer(),
            /*IconButton(
              onPressed: () async {
                bool playing = await AudioManager.instance.playOrPause();
                print("await -- $playing");
              },
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 48.0,
                color: Colors.black,
              ),
            ),*/
            GestureDetector(
                onTap: () async{
                  // if (isPlaying == true) {



                  /*----------ASMOBISOFT STRAT------*/
                  //bool playing = await AudioManager.instance.playOrPause();
                 // print("PLYINH $playing");
                  if (issongplaying) {
                    setState(() {
                      faIcon = FontAwesomeIcons.play;
                      // isPlayingFlag = !isPlaying;
                      issongplaying = false;
                      audioPlayer.pause();
                      firstOffset = -5.0;
                      secondOffset = -5.0;
                      audioPlayer.pause();

                    });
                  } else if (issongplaying == false) {
                    setState(() {
                      faIcon = FontAwesomeIcons.pause;
                      // isPlayingFlag = !isPlaying;
                      issongplaying = true;

                      firstOffset = 5.0;
                      secondOffset = 5.0;
                      audioPlayer.resume();
                    });

                  }
                  /*----------ASMOBISOFT END------*/
                },
                child: _neuPausePlay(faIcon)),
            Spacer(),
           /* IconButton(
                iconSize: 36,
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.black,
                ),
                onPressed: () => AudioManager.instance.next()),*/

            _neuControls(FontAwesomeIcons.forward, "next"),
            /*IconButton(
                icon: Icon(
                  Icons.stop,
                  color: Colors.black,
                ),
                onPressed: () => AudioManager.instance.stop()),*/
          ],
        ),
      ),
    ]);
  }

  Widget songProgress(BuildContext context) {
    var style = TextStyle(color: Colors.white);
    return Row(
      children: <Widget>[
        Text(
          _formatDuration(_position),
          style: style,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbColor: Colors.amberAccent,
                  overlayColor: Colors.amber,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.amberAccent,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  //value: _slider ?? 0,
                  value: _position.inSeconds.toDouble(),
                  max: _duration.inSeconds.toDouble() + 2,
                  onChanged: (value) {
                   /* setState(() {
                      _slider = value;
                    });*/

                    seekToSecond(value.toInt());
                    value = value;
                  },
                  onChangeEnd: (value) {
                    if (_duration != null) {
                      Duration msec = Duration(
                          milliseconds:
                          (_duration.inMilliseconds * value).round());
                      AudioManager.instance.seekTo(msec);
                    }
                  },
                )),
          ),
        ),
        Text(
          _formatDuration(_duration),
          style: style,
        ),
      ],
    );
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
  }
  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Future<MusicModel> fetchSubMusic(String catId) async {

    var url = "https://sataware.net/aaed/AppServices/API/getSubCategoryMusic";
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
          // 'sub_category_id': ConstantsHeading.musicSubCatId,
          'sub_category_id': "${catId}",
        }));

    if (response.statusCode == 200) {
      setState(() {
        var rsp = musicModelFromJson(response.body);

        myList = rsp.data;

        if (myList.isNotEmpty)
        {

          /* musicPlayer.play(MusicItem(
              trackName: 'Sample',
              albumName: 'Sample Album',
              artistName: 'Sample Artist',
              url: 'https://goo.gl/5RQjTQ',
              coverUrl: 'https://goo.gl/Wd1yPP',
              duration: Duration(seconds: 255),
            ))*/

          audioPlayer.play(myList[0].musicFile);
          //setupAudio();//initAudioPlayer(this);
        }
        print("mylist567 ${response.body}");
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

  Future<MusicModel> fetchMusic(String catId) async {

    var url = "https://sataware.net/aaed/AppServices/API/getTagMusic";
    final response = await http.post(url,
        body: jsonEncode(<String, String>{
         // 'sub_category_id': ConstantsHeading.musicSubCatId,
          'tag_id': "${catId}",
        }));

    if (response.statusCode == 200) {
      setState(() {
        var rsp = musicModelFromJson(response.body);

        myList = rsp.data;

        print("MMMM ${response.body}");
        if (myList.length>0)
          {
           audioPlayer.play(myList[0].musicFile);
            //setupAudio();//initAudioPlayer(this);
        }
        else
          {
            setState(() {

            });
          }

        print("mylist567 ${response.body}");
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

  void calculateCurrentTime(Duration d) {
    var timeSec = d.inSeconds;
    var timeMinute = d.inMinutes;
//  print("time is11 $timeSec  $timeMinute");

    if (timeSec < 60 && timeMinute == 0) {
      print("abs time:  ${d.abs().inSeconds}");
      currentDuration =
          timeMinute.toString() + ":".toString() + timeSec.toString();
    } else if (timeMinute > 0) {
      int sec = timeSec - timeMinute * 60;
      currentDuration = timeMinute.toString() + ":".toString() + sec.toString();
      print("time is :::   $sec  $timeMinute");
    }
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  // method to play the AUDIO from url
  Future play() async {
    // await audioPlayer.play(kUrl);
    await audioPlayer.play(myList[initialIndex].musicFile);

    setState(() {
      playerState = PlayerState.playing;
    });
  }

// method to pause the AUDIO from url
  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

// method to stop the AUDIO from url
  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  Widget _neuButton(IconData icon) {
    return InkWell(customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0XFF2e2e2e),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
            ),
            boxShadow: [
              new BoxShadow(
                color: Color(0XFF1c1c1c),
                offset: Offset(5.0, 5.0),
//                          spreadRadius: -5.0,
                blurRadius: 10.0,
              ),
              new BoxShadow(
                color: Color(0XFF404040),
                offset: Offset(-5.0, -5.0),
//                          spreadRadius: -5.0,
                blurRadius: 10.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(1.5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [Color(0XFF303030), Color(0XFF1a1a1a)]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Icon(
                icon,
                size: 5.4 * Responsive.imageSizeMultiplier,
                color: Colors.white38,
              ),
            ),
          ),
        ),
      ),
    );
  }

  var ind;
  Widget _neuControls(IconData faIcon,String task) {
    return InkWell(customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
      onTap: (){
        if(task=="previous")
          {
            if(ind >0)
              {
                ind--;
                //AudioManager.instance.stop();
                audioPlayer.stop();
                if(widget.list!=null && ind>=0)
                {
                  if(widget.list[ind].musicData.length>0)
                    fetchMusic(widget.list[ind].musicData[0].tagId);
                }
                else if(widget.sublist!=null && ind>=0)
                {
                  if(widget.sublist[ind].musicData.length>0)
                    fetchSubMusic(widget.sublist[ind].musicData[0].subCategoryId);
                }
                //fetchMusic(widget.list[ind].musicData[0].tagId);
              }

          }
        else{

          if(widget.list!=null && ind<widget.list.length || widget.sublist!=null && ind<widget.sublist.length )
            {
              ind++;
             // AudioManager.instance.stop();
              audioPlayer.stop();

              //fetchMusic(widget.list[ind].musicData[0].tagId);
              if(widget.list!=null)
              {
                if(widget.list[ind].musicData.length>0)
                  fetchMusic(widget.list[ind].musicData[0].tagId);
              }
              else if(widget.sublist!=null && ind<widget.sublist.length )
              {
                print("NEXT ${widget.sublist[ind]} index $ind");
                if(widget.sublist[ind].musicData!=null && widget.sublist[ind].musicData.length>0)
                  fetchSubMusic(widget.sublist[ind].musicData[0].subCategoryId);
              }
            }

        }
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0XFF2e2e2e),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
            ),
            boxShadow: [
              new BoxShadow(
                color: Color(0XFF1c1c1c),
                offset: Offset(5.0, 5.0),
//                          spreadRadius: -5.0,
                blurRadius: 10.0,
              ),
              new BoxShadow(
                color: Color(0XFF404040),
                offset: Offset(-5.0, -5.0),
//                          spreadRadius: -5.0,
                blurRadius: 10.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.amberAccent,
                width: 1.0,
              ),
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [Color(0XFF303030), Color(0XFF1a1a1a)]),
            ),
            child: Padding(
              padding: EdgeInsets.all(9.6 * Responsive.imageSizeMultiplier),
              child: FaIcon(
                faIcon,
                color: Colors.white54,
                size: 3.6 * Responsive.imageSizeMultiplier,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _neuPausePlay(IconData faIcon) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0XFF2e2e2e),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
          ),
          boxShadow: [
            new BoxShadow(
              color: Color(0XFF4a4a4a),
              offset: Offset(firstOffset, firstOffset),
              blurRadius: 6.0,
            ),
            new BoxShadow(
              color: Color(0XFF404040),
              offset: Offset(secondOffset, secondOffset),
              blurRadius: 6.0,
            ),
          ]),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.amber,
            width: 1.0,
          ),
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Colors.amberAccent, Colors.amber]),
        ),
        child: Padding(
          padding: EdgeInsets.all(9.6 * Responsive.imageSizeMultiplier),
          child: FaIcon(
            faIcon,
            color: Colors.white70,
            size: 3.6 * Responsive.imageSizeMultiplier,
          ),
        ),
      ),
    );
  }


  /*void setupAudio() {
    List<AudioInfo> _list = [];
    myList.forEach((item) => _list.add(AudioInfo(item.musicFile,
        title: item.musicName, desc: item.musicType, coverUrl: item.musicImage,)));
    AudioManager.instance.audioList = _list;

    AudioManager.instance.intercepter = true;
    AudioManager.instance.play(auto: true);

    AudioManager.instance.onEvents((events, args) {
      print("$events, $args");
      switch (events) {
        case AudioManagerEvents.start:
          print(
              "start load data callback, curIndex is ${AudioManager.instance.curIndex}");
          _position = AudioManager.instance.position;
          _duration = AudioManager.instance.duration;
          _slider = 0;
          setState(() {});
          break;
        case AudioManagerEvents.ready:
          print("ready to play");
          _error = null;
          _sliderVolume = AudioManager.instance.volume;
          _position = AudioManager.instance.position;
          _duration = AudioManager.instance.duration;
          setState(() {});
          // if you need to seek times, must after AudioManagerEvents.ready event invoked
          // AudioManager.instance.seekTo(Duration(seconds: 10));
          break;
        case AudioManagerEvents.seekComplete:
          _position = AudioManager.instance.position;
          _slider = _position.inMilliseconds / _duration.inMilliseconds;
          setState(() {});
          print("seek event is completed. position is [$args]/ms");
          break;
        case AudioManagerEvents.buffering:
          print("buffering $args");
          break;
        case AudioManagerEvents.playstatus:
          isPlayingFlag = AudioManager.instance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          _position = AudioManager.instance.position;
          _slider = _position.inMilliseconds / _duration.inMilliseconds;
          setState(() {});
          AudioManager.instance.updateLrc(args["position"].toString());
          break;
        case AudioManagerEvents.error:
          _error = args;
          print("ERROE $_error");
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          AudioManager.instance.next();
          break;
        case AudioManagerEvents.volumeChange:
          _sliderVolume = AudioManager.instance.volume;
          setState(() {});
          break;
        default:
          break;
      }
    });
  }*/

  /*void initAudioPlayer(_MusicPlayerState _songScreenState) {
    audioPlayer = AudioPlayer();

    _positionSubscription = audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        // print("timing current is: $p");
        position = p;

         var curentDura = Duration(
          hours: p.inHours, minutes: p.inMinutes, seconds: p.inSeconds);
    // updating the time in real time
        calculateCurrentTime(p);
      });
    });

    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() {
          _songScreenState.duration = _songScreenState.audioPlayer.duration;

          // calculating the total time of the track and setting
          calculateTotalTime(duration);
          musicIsPlaying = true;
          isPlayingFlag = true;
          faIcon = FontAwesomeIcons.pause;
        });
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
          print("timing of total tarck is :   $duration");
          //denoting that music has stopped
          faIcon = FontAwesomeIcons.play;

          musicIsPlaying = false;
          isPlayingFlag = false;
        });
      }
    }, onError: (msg) {
      setState(() {
        print(msg.toString());
        playerState = PlayerState.stopped;
        faIcon = FontAwesomeIcons.pause;

        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });

// track will play after 1 seconds becuase of autoplay issue
    Timer(Duration(seconds: 1), () {
      play();
    });
  }*/

  void calculateTotalTime(Duration d) {
    var timeSec = d.abs().inSeconds;
    var timeMinute = d.abs().inMinutes;

    if (timeMinute > 0) {
      int sec = timeSec - timeMinute * 60;
      totalDuration = timeMinute.toString() + ":".toString() + sec.toString();
    } else {
      totalDuration =
          timeMinute.toString() + ":".toString() + timeSec.toString();
    }
  }

  Future<bool> stopPlayer() {
    Navigator.of(context).pop();
    audioPlayer.stop();
    /*AudioManager.instance.release();
    AudioManager.instance.stop();*/

  }

}
