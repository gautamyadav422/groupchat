import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groupchat/screens/chat_screen.dart';
import 'package:groupchat/screens/login_screen.dart';
import 'package:groupchat/screens/registration_screen.dart';
import 'package:groupchat/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      initialRoute: WelcomeScreen.id,
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationPage.id: (context)=>RegistrationPage(),
        ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}

