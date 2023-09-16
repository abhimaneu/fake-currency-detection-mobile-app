import 'package:fakecurrency/home_screen_ui.dart';
import 'package:fakecurrency/output_page_ui.dart';
import 'package:fakecurrency/showimage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        height: 75,
        width: 75,
        child: FloatingActionButton(
          onPressed: () { 
            Navigator.push(context, MaterialPageRoute(builder: (context)=> homescreen_ui()));
          },
          //elevation: 0,
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
        title: Text("Fake Currency Detector",style: TextStyle(color: Colors.black26,fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _selectedIndex==0?SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 //SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.only(left: 10,top: 0,right: 10,bottom: 0),
                    child: Text("Home",style: TextStyle(color: Colors.black,fontSize: 40))
                ),
                SizedBox(height: 10,),

                Container(
                 // padding: EdgeInsets.only(bottom: 100),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context,index){
                    return ListTile(
                      leading: Icon(Icons.note),
                      title: Text("Fake Note ${index+1}"),
                    );
                  }),
                ),
              ],

          ),
        ),
      ):Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 75,),
            Container(
                padding: EdgeInsets.only(left: 10,top: 0,right: 10,bottom: 0),
                child: Text("News",style: TextStyle(color: Colors.black,fontSize: 40))
            ),
            SizedBox(height: 10,),
          ],
        ),
      )
    );
  }
}
