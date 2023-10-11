import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakecurrency/dashboard.dart';
import 'package:fakecurrency/output_page_ui.dart';
import 'package:fakecurrency/showimage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:fakecurrency/home_screen_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Map<int, Color> color =
{
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};
MaterialColor colorCustom = MaterialColor(0xFFf8b195, color);
var firebaseDB;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebaseDB = FirebaseFirestore.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Fake Currency',
      theme: ThemeData(
        useMaterial3: true,
         colorScheme: ColorScheme.fromSeed(
             seedColor: Color(0xFF0A1944)
         ),
         //useMaterial3: true,
        primarySwatch: colorCustom,
        primaryColor: Colors.white70,
        canvasColor: Colors.white70,
        // appBarTheme: AppBarTheme(
        //   shape: ContinuousRectangleBorder(
        //       borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(0),
        //           bottomRight: Radius.circular(0)
        //       )
        //   ),
        //   //backgroundColor: Colors.white,
        //   centerTitle: true,
        // ),
          appBarTheme: AppBarTheme(
              centerTitle: false,
              backgroundColor: Color(0xFF0A1944),
              titleTextStyle: TextStyle(color: Colors.white70,fontSize: 25),
              elevation: 0,
            ),

        fontFamily: 'OpenSans',
        primaryColorLight: Colors.black26,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme
        )
        // textTheme: const TextTheme(
        //   headlineLarge: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black),
        //   displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        //   displayMedium: TextStyle(fontSize: 26,color: Colors.black87, fontWeight: FontWeight.w500),
        //   titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
        //   bodyMedium: TextStyle(fontSize: 14, fontFamily: 'OpenSans'),
        // ),
      ),
      home: dashboard()
    );
  }
}