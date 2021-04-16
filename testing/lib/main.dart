import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/Screens/ChatRoom.dart';
import 'package:testing/Screens/Home.dart';
import 'package:testing/Screens/Login.dart';
import 'package:testing/Screens/SignUp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.white,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        SignUpScreen.routName: (_) => SignUpScreen(),
        HomeScreen.routName: (_) => HomeScreen(),
        ChatRoom.routName: (_) => ChatRoom(),
      },
    );
  }
}
