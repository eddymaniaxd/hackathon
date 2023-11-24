

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Files {
  
  File? _file;
  String? path;
  
  Files(path){
    this.path = path;
  }

  File? get getfile => _file;
  set setfile(File file){
    _file = file;
  }  

  String get getPath => path!;


  static Future upLoadImage(String path, String nameImage, File file) async {

    if(file == null) return;

    // String fileName = basename(files!.path); //Nombre de la imagen
    print("PATH: $path");
    String destination = path; //route
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('$nameImage/'); //name image
      await ref.putFile(file);
    } catch (e) {
      print('error occured');
    }
      
  }

  static Future<String> loadImage(String imageUrl) async{
      // String path, String nameImage
      var pathAndNamed = imageUrl.split("/"); 
      firebase_storage.Reference  ref = FirebaseStorage.instance.ref().child(pathAndNamed[0]).child(pathAndNamed[1]);
      
      //get image url from firebase storage
      var url = await ref.getDownloadURL();
      print('url: ' + url);
      return url;
  }
  
}