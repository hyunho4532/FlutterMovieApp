import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {

  final storageRef= FirebaseStorage.instance.ref();


  var selectedImagePath = ''.obs;

  void getImage(ImageSource imageSource, FirebaseAuth getAuth) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      getFileUpload(selectedImagePath.value, getAuth);
    } else {
      print("No image selected");
    }
  }

  void getFileUpload(String value, FirebaseAuth getAuth) async {
    final storageRef= FirebaseStorage.instance.ref('profile/');
    final mountainsRef = storageRef.child('${getAuth.currentUser!.uid}.png');

    File file = File(selectedImagePath.toString());

    mountainsRef.putFile(file);
  }
}