import 'dart:convert';

import 'package:fakecurrency/showimage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:io';
import 'api.dart';
import 'package:http/http.dart';

class output_page_ui extends StatefulWidget {
  @override
  State<output_page_ui> createState() => _output_page_uiState();
}

class _output_page_uiState extends State<output_page_ui> {
  // const output_page_ui({Key? key}) : super(key: key);
  late String url = 'https://godseye.pythonanywhere.com/api';

  var Data;

  var noteData;

  bool loading = true;
  Color percolor = Colors.green;

  int count = 10;
  var result = "PASS";
  double percentage = 100;

  get slidervalue => null;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    Data = await Getdata(url);
    noteData = jsonDecode(Data.body);
    for(int i=0;i<noteData.length;i++){
      if(noteData[i]['success'] != 'true'){
        count = count-1;
        result = "FAIL";
      }
      percentage = (count / 10) * 100;
    }
    if(count>8){
      percolor = Colors.green;
    }
    else if(count>6) {
      percolor = Colors.orange;
    }
    else {
      percolor = Colors.red;
    }
    setState(() {
      loading = false;
    });
    print(noteData);
    print(percentage);
    print(result);
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
        title: Text("Fake Currency Detector",style: TextStyle(color: Colors.black26,fontSize: 25),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: loading?Center(child: CircularProgressIndicator()):Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        color: Theme.of(context).primaryColor,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.only(left: 10,top: 0,right: 10,bottom: 0),
                child: Text("Result",style: TextStyle(color: Colors.black,fontSize: 35))
            ),
            SizedBox(height: 20,),
            Center(
              child: result=="PASS"?Text("Passed",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green[700]),):Text("Failed",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.red[700]),),
            ),
            SizedBox(height: 5,),
            Center(
              child: result=="PASS"?Text("This note is Genuine",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.green[800]),):Text("There is a chance that the note is Fake",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.deepOrangeAccent),),
            ),
            SizedBox(height: 10,),
            Center(child: Container(
              height: 250,
              width: 320,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Center(
                child: Text("Note Image"),
              ),
            )),
            SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("    Final Score ",style: TextStyle(
                        fontSize: 20
                      ),),
                      //Text("80%",style: Theme.of(context).textTheme.displayMedium,),
                      SizedBox(height: 0,)
                    ],
                  ),
                  SizedBox(height: 5,),
                  CircularPercentIndicator(
                    radius: 60,
                    lineWidth: 8,
                    animation: true,
                    percent: percentage / 100,
                    progressColor: percolor,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text("${(percentage/10).round()}/10",style: TextStyle(fontSize: 20),),
                    footer: Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text("The Note passed ${percentage.toStringAsPrecision(2)}% of our Tests")),
                  ),
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
    );
  }
}
