import 'package:fakecurrency/output_page_ui.dart';
import 'package:fakecurrency/showimage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

Future Getdata(url) async {


    return http.get(Uri.parse('https://godseye.pythonanywhere.com/api'));


}