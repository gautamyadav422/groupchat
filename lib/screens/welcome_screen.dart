import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:groupchat/screens/registration_screen.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
   late AnimationController controller;
   late Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    controller.forward();
    controller.addListener(() {
      setState(() {});

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Container(
          color: Colors.blueGrey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Hero(
                          tag: "logo",
                          child: Container(
                            child: Image.asset('images/logo.png'),
                            height: 60.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextLiquidFill(
                          text: ' TryCatch Group Chat',
                          waveColor: Colors.deepOrange,
                          waveDuration: Duration(seconds: 2),
                          textStyle: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                          ),
                          boxHeight: 100.0,
                          boxBackgroundColor: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text("Login"),
                ),
                // RoundedButton(
                //   title: 'Log In',
                //   colors: Colors.green,
                //   onPress: (){
                //     Navigator.pushNamed(context, LoginScreen.id);
                //   },
                // ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationPage.id);
                  },
                  child: Text("Sign Up"),
                ),

                // RoundedButton(
                //   title: 'Sign Up',
                //   colors: Colors.red,
                //   onPress: () {
                //     Navigator.pushNamed(context, RegistrationPage.id);
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
