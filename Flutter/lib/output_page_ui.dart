import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakecurrency/main.dart';
import 'package:fakecurrency/showimage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:io';
import 'api.dart';
import 'package:http/http.dart';
import 'home_screen_ui.dart';

class output_page_ui extends StatefulWidget {
  @override
  State<output_page_ui> createState() => _output_page_uiState();
}

class _output_page_uiState extends State<output_page_ui> {
  final TextEditingController _feedbackcon = TextEditingController();
  // const output_page_ui({Key? key}) : super(key: key);
  late String url = 'https://godseye.pythonanywhere.com/api';

  var Data;
  var noteData;

  var urlDownload;

  bool loading = true;
  bool error = false;
  Color percolor = Colors.green;

  int count = 10;
  var result = "FAIL";
  double percentage = 0;

  get slidervalue => null;

  UploadTask? uploadTask;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  String feedbackData = "";

  feedback(feedbackdata) {
    feedbackData = feedbackdata;
  }

  getdata() async {
    //FIREBASE STORAGE
    final filepath = 'allNotes/${image!.name}';
    final uploadimage = File(image!.path);
    final storageRef = FirebaseStorage.instance.ref().child(filepath);
    uploadTask = storageRef.putFile(uploadimage);

    final snapshot = await uploadTask!.whenComplete(() => {});

    urlDownload = await snapshot.ref.getDownloadURL();
    print(urlDownload);

    //CALLING API
    var fetchurl = url + '?img=${urlDownload}';
    print(fetchurl);
    // try {
    Data = await Getdata(fetchurl);
    noteData = jsonDecode(Data.body);
    for (int i = 0; i < noteData.length; i++) {
      if (noteData[i]['success'] != 'true') {
        count = count - 1;
        result = "FAIL";
      }
      percentage = (count / 10) * 100;
    }

    if (count >= 8) {
      percolor = Color(0xFF688D71);
      result = "PASS";
    } else if (count > 6) {
      percolor = Colors.orange;
      result = "FAIL";
    } else {
      percolor = Color(0xFFC2350A);
    }
    setState(() {
      loading = false;
    });
    print(noteData);
    print(percentage);
    // }on Exception catch(e) {
    //   print("ERROR");
    //   print(Data);
    //   setState(() {
    //     loading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   centerTitle: false,
      //   automaticallyImplyLeading: false,
      //   bottomOpacity: 0,
      //   elevation: 0,
      //   titleTextStyle: TextStyle(
      //       fontSize: 28, fontWeight: FontWeight.normal),
      //   title: Text("Fake Currency Detector",style: TextStyle(color: Colors.black87,),),
      // ),
      appBar: AppBar(
        title: Text("Fake Currency Detector"),
        automaticallyImplyLeading: false,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : count == 0
              ? Center(
                  child: Text("Please reupload Note Image"),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    color: Theme.of(context).primaryColor,
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //     padding: EdgeInsets.only(left: 15,top: 0,right: 15,bottom: 0),
                        //     child: Text("Result",style: TextStyle(color: Colors.black,fontSize: 35))
                        // ),
                        //Container(height: 0.2,margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),color: Color(0xFF0A1944),),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: result == "PASS"
                              ? Text(
                                  "Passed",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF688D71)),
                                )
                              : Text(
                                  "Failed",
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC2350A)),
                                ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: result == "PASS"
                              ? Text(
                                  "This note is Genuine",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF688D71)),
                                )
                              : Text(
                                  "There is a chance that this Note is Fake",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFFC2350A)),
                                ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                          //height: 200,
                          // width: 340,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF0A1944)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 30,
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    " Final Score ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  //Text("80%",style: Theme.of(context).textTheme.displayMedium,),
                                  SizedBox(
                                    height: 0,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CircularPercentIndicator(
                                radius: 60,
                                lineWidth: 8,
                                animation: true,
                                percent: percentage / 100,
                                progressColor: percolor,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: Text(
                                  "${(percentage / 10).round()}/10",
                                  style: TextStyle(fontSize: 20),
                                ),
                                footer: Container(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 5),
                                    child: Text(
                                        "The Note passed ${percentage.toStringAsPrecision(3)}% of our Tests")),
                              ),
                              //SizedBox(height: 10,),
                              // TextButton(
                              //   onPressed: () {
                              //
                              //   },
                              //   child: Text("View Detailed Report",style: TextStyle(fontSize: 12,color: Color(0xff3C4F6D),decoration: TextDecoration.underline),),
                              // ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 0.2,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                color: Color(0xFF0A1944),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Found Any Issues?"),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: _feedbackcon,
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Report your Issues/Comments Here',
                                  filled: false,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    print(_feedbackcon.text);

                                    final data = <String, dynamic>{
                                      "feedback": _feedbackcon.text,
                                    };

                                    firebaseDB
                                        .collection("userFeedbacks")
                                        .add(data);
                                  },
                                  child: Text("Submit Feedback"))
                            ],
                          ),
                        ),

                        //-----------MAKE THIS LISTVIEW BUILDER FOR DISPLAYING ALL FEATURES-----------
                        // Expanded(
                        //   child: ListView.builder(
                        //     shrinkWrap: true,
                        //       itemCount: 10,
                        //       itemBuilder: (context , index) {
                        //       return ListTile(
                        //         title: Text("Feature ${index+1}",),
                        //         subtitle: Text("Pass"),
                        //         trailing: Icon(Icons.photo),
                        //       );
                        //   }),
                        // )
                        //-------------------------------------------
                      ],
                    ),
                  ),
                ),
    );
  }
}
