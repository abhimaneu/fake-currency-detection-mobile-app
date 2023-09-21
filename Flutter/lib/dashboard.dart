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
                    padding: EdgeInsets.only(left: 20,top: 0,right: 15,bottom: 0),
                    child: Text("Saved Notes",style: TextStyle(color: Colors.black87,fontSize: 20))
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context,index){
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.note),
                          title: Text("Fake Note ${index+1}"),
                        ),
                        Container(height: 0.2,color: Colors.black26,)
                      ],
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
            SizedBox(height: 25,),
            Container(
                padding: EdgeInsets.only(left: 20,top: 0,right: 15,bottom: 0),
                child: Text("Headlines",style: TextStyle(color: Colors.black87,fontSize: 20))
            ),
            SizedBox(height: 10,),
          ],
        ),
      )
    );
  }
}
