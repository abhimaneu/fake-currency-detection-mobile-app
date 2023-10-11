import 'dart:ui';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen_ui.dart';

class ImageCrop_Service {
  Future<XFile?> pickCropImage({
    required CropAspectRatio cropAspectRatio,
}) async {
    //XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    //if(pickImage == null) {return null}

    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
     uiSettings: [
       AndroidUiSettings(
         toolbarWidgetColor: Color(0xFF0A1944),
         toolbarTitle: "Crop Note",
         //initAspectRatio: CropAspectRatioPreset.ratio16x9,
         lockAspectRatio: false,
       ),
       IOSUiSettings(
         title: "Crop Note",
         aspectRatioLockEnabled: false,
       )
     ]
     //aspectRatio: CropAspectRatio(ratioX: 2 , ratioY: 1),
    );
    if(croppedFile == null) {return null;};

    return XFile(croppedFile.path);
  }
}