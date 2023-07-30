import 'package:fakecurrency/showimage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

List<CameraDescription>? cameras; //list out the camera available
CameraController? controller; //controller for camera
XFile? image; //for caputred image
ImagePicker picker = ImagePicker();

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

// REPLACE FOR CAMERA
// class _homescreenState extends State<homescreen> {
//   List<CameraDescription>? cameras; //list out the camera available
//   CameraController? controller; //controller for camera
//   XFile? image; //for caputred image
//
//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//   }
//
//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     super.dispose();
//   }
//
//
//  initializeCamera() async {
//     cameras = await availableCameras();
//     if(cameras != null){
//       controller = CameraController(cameras![0], ResolutionPreset.max);
//       //cameras[0] = first camera, change to 1 to another camera
//
//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     }else{
//       print("NO any camera found");
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           height: MediaQuery.of(context).size.height * 0.80,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               Container(
//
//                 child: controller == null?
//                 Center(
//                   child: Text('Loading Camera')
//                 ):!controller!.value.isInitialized?
//                 Center(
//                 child: CircularProgressIndicator()
//                   ,):CameraPreview(controller!)
//                 ),
//               Container( //show captured image
//                 padding: EdgeInsets.all(30),
//                 child: image == null?
//                 Text("No image captured"):
//                     Text("Picture Captured"),
//                 //Image.file(File(image!.path), height: 300,),
//                 //display captured image
//               )
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async{
//             try {
//               if(controller != null){ //check if contrller is not null
//                 if(controller!.value.isInitialized){ //check if controller is initialized
//                   controller?.setFlashMode(FlashMode.off);
//                   image = await controller!.takePicture(); //capture image
//                   setState(() {
//                     //update UI
//                   });
//                 }
//               }
//             } catch (e) {
//               print(e); //show error
//             }
//           },
//           child: Icon(Icons.camera),
//         ),
//         ),
//       );
//   }
// }

class _homescreenState extends State<homescreen> {
  int cameraFlag = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera(0);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    super.dispose();
  }

  initializeCamera(cameraNo) async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![cameraNo], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        title: Text("Fake Detecter"),
      ),
      body: SingleChildScrollView(
        child: controller == null
            ? Center(child: Text('Loading Camera'))
            : !controller!.value.isInitialized
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height * 0.6),
                        // controller!.value.aspectRatio,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,
                        ),

                        child: CameraPreview(controller!),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //SizedBox(height: 100,),
                            IconButton(
                                onPressed: () async {
                                  image = await picker.pickImage(source: ImageSource.gallery);
                                  if(image != null) {
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => showimage()));
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.photo,
                                  size: 30,
                                )),
                            Ink(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 5),
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  try {
                                    if (controller != null) {
                                      //check if contrller is not null
                                      if (controller!.value.isInitialized) {
                                        //check if controller is initialized
                                        controller?.setFlashMode(FlashMode.off);
                                        image = await controller!
                                            .takePicture(); //capture image
                                        setState(() {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => showimage()));
                                        });
                                      }
                                    }
                                  } catch (e) {
                                    print(e); //show error
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 60.0,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if(cameraFlag == 0) {
                                    initializeCamera(1);
                                    cameraFlag = 1;
                                  }
                                  else {
                                    initializeCamera(0);
                                    cameraFlag = 0;
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.flip_camera_android,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
