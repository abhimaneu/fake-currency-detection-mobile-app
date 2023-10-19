import 'package:fakecurrency/home_screen_ui.dart';
import 'package:fakecurrency/output_page_ui.dart';
import 'package:fakecurrency/showimage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        height: 75,
        width: 75,
        child: FloatingActionButton(
          elevation: 2,
          onPressed: () { 
            Navigator.push(context, MaterialPageRoute(builder: (context)=> homescreen_ui()));
          },
          child: Icon(Icons.camera_alt_outlined,size: 40,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper),label: 'News')
        ],
      ),
      appBar: AppBar(
        title: Text("Fake Currency Detector"),
      ),
      body: _selectedIndex==0?SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 //SizedBox(height: 40,),
                // Container(
                //   padding: EdgeInsets.only(left: 15,top: 0,right: 15,bottom: 0),
                //     child: Text("Home",style: TextStyle(color: Colors.black,fontSize: 40))
                // ),
                SizedBox(height: 5,),
                // Container(padding: EdgeInsets.symmetric(horizontal: 5),
                // child: Container(height: 1,color: Colors.blueGrey,),),
                SizedBox(height: 20,),
                Container(
                    padding: EdgeInsets.only(left: 10,top: 0,right: 15,bottom: 0),
                    child: Text("Welcome",style: TextStyle(color: Colors.black87,fontSize: 30))
                ),
                SizedBox(height: 10,),
                SizedBox(height: 10,),
                Text(
                  "        Detect counterfeit currency with ease using our advanced image analysis technology. Simply snap a picture of a banknote, and our app will quickly assess its authenticity. Stay informed with real-time currency news and exchange rates. Explore educational resources and protect your finances. Your security is our priority.",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20,),
                Text("How to Use?",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text("\u2022 Click On Camera icon Below",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify),
                SizedBox(height: 5,),
                Text("\u2022 Select the note you want to scan",style: TextStyle(fontSize: 16),),
                SizedBox(height: 5,),
                Text("\u2022 Take a clear picture of the note using the camera or form Gallery",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify),
                Container(padding: EdgeInsets.only(left: 15),
                  child: Text("Make Sure the banknote is flat, without any creases or folds, to capture a clear and accurate image",
                    style: TextStyle(fontSize: 16,color: Colors.grey[600]),textAlign: TextAlign.justify,),
                ),
                SizedBox(height: 5,),
                Text("\u2022 Crop the image of the banknote to ensure no background is there , this will help get accurate results",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify),
                SizedBox(height: 5,),
                Text("\u2022 You can see the result after the Note has been checked",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify),
                SizedBox(height: 20,),

                Text("Things to Note:",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text("\u2022 The Result will show a score out of 10 based on the analysis, If the note meet the minimum score it will be considered Pass else Fail",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify),
                SizedBox(height: 5,),
                Text("\u2022 Make Sure not to use the app for any Immoral purposes",style: TextStyle(fontSize: 16),textAlign: TextAlign.justify),

              ],

          ),
        ),
      ):Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25,),
            Container(
                padding: EdgeInsets.only(left: 20,top: 0,right: 15,bottom: 0),
                child: Text("Headlines",style: TextStyle(color: Colors.black87,fontSize: 30))
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                SizedBox(height: 10,),
                GestureDetector(

                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network("https://c.ndtvimg.com/2023-10/7oddbbk8_web-series-farziinspired-fake-currency-racket-busted-in-delhi-5-arrested_120x90_07_October_23.jpg",height: 100,),
                        SizedBox(width: 10,),
                        Flexible(child: Text("Web Series 'Farzi'-Inspired Fake Currency Racket Busted In Delhi, 5 Arrested",style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),)),
                      ],
                    ),
                  ),
                ),

                //NEWS 2
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.network("https://c.ndtvimg.com/2023-02/p5saa8sg_rupees-500-and-100-indian-currency-notes_120x90_24_February_23.jpg",height: 100,),
                      SizedBox(width: 10,),
                      Flexible(child: Text("Fake Currency Racket Busted, 3 Arrested In Assam",style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),)),
                    ],
                  ),
                ),

                //NEWS 3
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.network("https://i.ndtvimg.com/i/2016-06/court-generic_240x180_51465821016.jpg",height: 100,),
                      SizedBox(width: 10,),
                      Flexible(child: Text("Anti-Terror Agency Court Convicts 6th Accused In Bengaluru Fake Currency Case",style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),)),


                    ],
                  ),
                ),

                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.all(10),
                //   child: Row(
                //     children: [
                //       Image.network("https://i.ndtvimg.com/i/2016-06/court-generic_240x180_51465821016.jpg",height: 100,),
                //       SizedBox(width: 10,),
                //       Flexible(child: Text("Anti-Terror Agency Court Convicts 6th Accused In Bengaluru Fake Currency Case",style: TextStyle(
                //           fontWeight: FontWeight.bold
                //       ),)),
                //
                //
                //     ],
                //   ),
                // ),
                //
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.all(10),
                //   child: Row(
                //     children: [
                //       Image.network("https://c.ndtvimg.com/2023-07/6il7avjg_manav-arora_120x90_09_July_23.jpg",height: 100,),
                //       SizedBox(width: 10,),
                //       Flexible(child: Text("Doctor Gets Fake Rs 500 Note From Patient, Shares How He Was 'Conned'",style: TextStyle(
                //           fontWeight: FontWeight.bold
                //       ),)),
                //
                //
                //     ],
                //   ),
                // ),
              ],
            )
          ],
        ),
      )
    );
  }
}
