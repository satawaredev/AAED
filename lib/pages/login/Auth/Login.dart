

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sensoryscope/data/pref_manager.dart';
import 'package:sensoryscope/pages/home/home.dart';

import '../Animation/AnimationBuildLogin.dart';
import '../Constant/ColorGlobal.dart';
import '../Constant/TextField.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  bool showvalue = false;
  double width = 400.0;
  double widthIcon = 180.0;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  String username;
  getDisposeController() {
    email.clear();
    password.clear();
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getDisposeController();
  }

  @override
  void dispose() {
    //getDisposeController();
    // TODO: implement dispose
    super.dispose();
  }

  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: ColorGlobal.whiteColor,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(),
                height: size.height,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Colors.amberAccent,
                      Colors.amber,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
//                top: keyboardOpen ? -size.height / 3.2 : 0.0,
                child: AnimationBuildLogin(
                  size: size,
                  yOffset: size.height / (1.15),
                  color: Colors.amberAccent,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: (130)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      height: 250,
                      width: 250,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width:5,
              ),
              Padding(
                padding: EdgeInsets.only(top:(380)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sensoryscape',
                      style: TextStyle(
                        color: ColorGlobal.whiteColor,
                        fontSize: 24.0,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 22,
                  left: 22,
                  bottom: 22,
                  top:450,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TextFieldWidget(
                        hintText: 'User Name',
                        obscureText: false,
                        prefixIconData: Icons.person,
                        textEditingController: email,
                        focusNode: emailFocus,
                        onChanged: (val){
                          setState(() {
                            username = email.value.text;
                          });
                          print("CHANGES ${val} ===> ${email.text}");
                        },
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(children:[
                      Checkbox(
                        value: this.showvalue,
                        onChanged: (bool value) {
                          setState(() {
                            this.showvalue = value;
                          });
                        },
                      ),Text('Remember me',style:TextStyle(color: Colors.white,fontSize: 18)),
                    ]),

                    Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(
                        top: (40),
                        right: (8),
                        left: (8),
                        bottom: (20),
                      ),
                      child: loginButtonUI()/*AuthButton(username: username,)*/,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget loginButtonUI()
  {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          setState(() {
            //Starts animation
            print("USERNAMEEE==>${email.value.text}");

            if(isValid())
              {
                saveUsername();
              }


          });
        },
        child: Hero(
          tag: 'blackBox',
          flightShuttleBuilder: (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
              ) {
            return Container(
              decoration: BoxDecoration(
                color: ColorGlobal.colorPrimaryDark,
                shape: BoxShape.circle,
              ),
            );
          },
          child: Container(
            height: (60.0),
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    Colors.amberAccent,
                    Colors.amber,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorGlobal.colorPrimary.withOpacity(0.6),
                    spreadRadius: 5,
                    blurRadius: 20,
                    // changes position of shadow
                  ),
                ],
                border: Border.all(
                  width: 2,
                  color: Colors.amberAccent, //                   <--- border width here
                ),
                color: ColorGlobal.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular((22.0)))),
            child: Container(
//                        margin: EdgeInsets.only(left: (10)),
              alignment: Alignment.center,
              child: Text(
                "PROCEED",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if(email.value.text.isEmpty )
    {
      Fluttertoast.showToast(
          msg: "Please enter your username to continue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.black,
          fontSize: 16.0
      );
      return false;
    }

    if( email.value.text.length<4)
    {
      Fluttertoast.showToast(
          msg: "Username should be atleast 4 characters",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.black,
          fontSize: 16.0
      );
      return false;
    }
    return true;
  }

  void saveUsername() async{
    if (Prefs.getString("username")==null)
      {
        await Prefs.setString("username", email.value.text.toString());
        goHome();
      }
   else{
      if(Prefs.getString("username")==email.value.text.toString())
        {
          goHome();
        }

       else
        {
          await Prefs.setString("username", email.value.text.toString());
          goHome();
          /*Fluttertoast.showToast(
              msg: "Invalid username",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              fontSize: 16.0
          );*/
        }
    }

  }

  void goHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
  }
}

