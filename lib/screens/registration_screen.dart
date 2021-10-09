import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:groupchat/constants.dart';
import 'package:groupchat/screens/chat_screen.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  static const String id = "registration_screen";

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var email;
  var password;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ModalProgressHUD(
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
                          //Do something with the user input.
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
                            //Do something with the user input.
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your password')),
                      SizedBox(
                        height: 24.0,
                      ),
                      ElevatedButton(
                          child: Text("Register".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate())
                              setState(() {
                                loading = true;
                              });
                            try {
                              final FirebaseUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                    "Registered Successfully. Please Login..",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              );
                              if (FirebaseUser != null) {
                                Navigator.pushNamed(context, ChatScreen.id);
                              }
                              setState(() {
                                loading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print("Password Provided is too Weak");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.orangeAccent,
                                    content: Text(
                                      "Password Provided is too Weak",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                  ),
                                );
                              } else if (e.code == 'email-already-in-use') {
                                print("Account Already exists");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.orangeAccent,
                                    content: Text(
                                      "Account Already exists",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                  ),
                                );
                              }
                              print(e);
                            }
                          })
//                     RoundedButton(
//                         title: 'Register',
//                         colors: Colors.blueAccent,
//                         onPress: () async{
// //                print(email);
// //                print(password);
//                           setState(() {
//                             loading = true;
//                           });
//                           try{
//                             final FirebaseUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//                             if(FirebaseUser!=null){
//                               Navigator.pushNamed(context, LoginScreen.id);
//                             }
//                             setState(() {
//                               loading = false;
//                             });
//                           }catch(e){
//                             print(e);
//                           }
//                         }
//
//                     )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
