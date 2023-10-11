import 'package:fakecurrency/imagecrop_service.dart';
import 'package:fakecurrency/output_page_ui.dart';
import 'package:fakecurrency/showimage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

List<CameraDescription>? cameras; //list out the camera available
CameraController? controller; //controller for camera
XFile? image; //for caputred image
ImagePicker picker = ImagePicker();

class homescreen_ui extends StatefulWidget {
  const homescreen_ui({Key? key}) : super(key: key);

  @override
  State<homescreen_ui> createState() => _homescreen_uiState();
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

class _homescreen_uiState extends State<homescreen_ui> {
  int cameraFlag = 0;
  int _flashStatus = 0;

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
      controller?.setFlashMode(FlashMode.off);
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
    ResolutionPreset.max;

    //FLASH TOGGLE
    if (_flashStatus == 0) {
      controller?.setFlashMode(FlashMode.off);
    } else {
      controller?.setFlashMode(FlashMode.torch);
    }

    List<Icon> flashIcon = [
      Icon(
        Icons.flash_off,
        color: Colors.white,
      ),
      Icon(
        Icons.flash_on,
        color: Colors.white,
      )
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   backgroundColor: Colors.black26,
      //   leading: Icon(
      //     Icons.flash_on,
      //     color: Colors.white,
      //   ),
      //   actions: [
      //     Icon(Icons.close,color: Colors.white,),
      //     SizedBox(width: 8,)
      //   ],
      //   centerTitle: true,
      //   bottomOpacity: 0,
      //   elevation: 0,
      //   titleTextStyle: TextStyle(
      //       fontSize: 28, fontWeight: FontWeight.normal),
      //   //title: Text("Fake Currency Detecter",style: TextStyle(fontSize: 20,color: Colors.black87),),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: controller == null
              ? Center(child: Text('Loading Camera'))
              : !controller!.value.isInitialized
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help_outline,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      //FLASH TOGGLE
                                      _flashStatus == 1
                                          ? _flashStatus = 0
                                          : _flashStatus = 1;
                                    });
                                  },
                                  icon: flashIcon[_flashStatus]),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            CameraPreview(controller!),
                            Container(
                                //color: Colors.white,
                                child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.55,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 160,),
                                      CustomPaint(
                                        foregroundPainter: BorderPainter(),
                                        child: Container(
                                          color: Colors.transparent,
                                          width: 350,
                                          height: 200,
                                        ),
                                      ),
                                      // Text(
                                      //   "Make Sure the Currency is Aligned properly",
                                      //   style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ],
                                  )),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  image =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  image = await ImageCrop_Service().pickCropImage(
                                                    cropAspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
                                                  );
                                                  if (image != null) {
                                                    setState(() {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  output_page_ui()));
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .photo_size_select_actual_outlined,
                                                  color: Colors.white,
                                                  size: 30,
                                                )),
                                            GestureDetector(
                                              onTap: () async {
                                                image = await controller!
                                                    .takePicture(); //capture image
                                                image = await ImageCrop_Service().pickCropImage(
                                                  cropAspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
                                                );
                                                controller?.setFlashMode(FlashMode.off);
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            output_page_ui()));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    //color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: Icon(
                                                  Icons.circle,
                                                  color: Colors.white,
                                                  size: 75,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (cameraFlag == 0) {
                                                    initializeCamera(1);
                                                    cameraFlag = 1;
                                                  } else {
                                                    initializeCamera(0);
                                                    cameraFlag = 0;
                                                  }
                                                });
                                              },
                                              icon: Icon(
                                                Icons
                                                    .flip_camera_android_outlined,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ))
                              ],
                            )),
                          ],
                        )
                      ],
                    ),
        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.1; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
