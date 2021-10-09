import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:groupchat/constants.dart';
import 'package:groupchat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool loading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: ModalProgressHUD(
            inAsyncCall: loading,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Email Id";
                      } else if (!value.contains("@")) {
                        return "Please Enter Valid Email Id";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  ElevatedButton(
                      child: Text("Login".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.red)))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate())
                        setState(() {
                          loading = true;
                        });

                        try {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString("email", email);
                          prefs.setString("password", password);
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          setState(() {
                            loading = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print("No User Found for that Email");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orangeAccent,
                                content: Text(
                                  "No User Found for that Email",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                ),
                              ),
                            );
                          } else if (e.code == 'wrong-password') {
                            print("Wrong Password Provided by User");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orangeAccent,
                                content: Text(
                                  "Wrong Password Provided by User",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                ),
                              ),
                            );
                          }
                          print(e);
                        }
                      })
                  // RoundedButton(
                  //   title: 'Log In',
                  //   colors: Colors.blueAccent,
                  //   onPress: () async {
                  //     setState(() {
                  //       loading = true;
                  //     });
                  //
                  //     try{
                  //       final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  //       if(user != null){
                  //         Navigator.pushNamed(context, ChatScreen.id);
                  //       }
                  //       setState(() {
                  //         loading = false;
                  //       });
                  //     }catch(e){
                  //       print(e);
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
