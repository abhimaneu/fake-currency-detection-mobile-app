import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'home_screen_ui.dart';

class showimage extends StatefulWidget {
  const showimage({Key? key}) : super(key: key);

  @override
  State<showimage> createState() => _showimageState();
}

class _showimageState extends State<showimage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),
        title: Text("Fake Detecter"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.black26,

              ),
              padding: EdgeInsets.all(10),
              child:  image == null?
              Text("No Image Found"):Image.file(File(image!.path),fit: BoxFit.fitWidth,),
            ),
          ],
        ),
      ),
    );
  }
}
