import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modnsport/repositories/storage/storage.repository.firebase.dart';

class StorageRepository extends StorageRepositoryFirebase{

  @override
  Future<Map<String, dynamic>> uploadVideo({required File videoFile}) async{
    final storageRef = FirebaseStorage.instance.ref();
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
      return throw("you're not connected");
    }

    User? user = FirebaseAuth.instance.currentUser;
    var refUserVideos = storageRef.child("videos/$videoFile");
    var task = refUserVideos.putFile(videoFile);
    var downloader = refUserVideos.getDownloadURL();
    return {"task":task, "url": downloader};
  }

  @override
  Future<Map<String, dynamic>> uploadImage({required File imageFile, bool admin= false}) async{
    final storageRef = FirebaseStorage.instance.ref();
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
      return throw("you're not connected");
    }
    Reference refUserImage;

    if(admin){refUserImage = storageRef.child("images/admin/$imageFile");
    }else{
      User? user = FirebaseAuth.instance.currentUser;
      refUserImage = storageRef.child("images/${user?.uid}/$imageFile");
    }

    UploadTask task = refUserImage.putFile(imageFile);
    Future<String> downloader = refUserImage.getDownloadURL();
    return {"task":task, "url": downloader};
  }

  @override
  Future<Map<String, dynamic>> adminUploadImage({required File imageFile})async {
    final storageRef = FirebaseStorage.instance.ref();
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
      return throw("you're not connected");
    }

    var refUserImage = storageRef.child("images/admin/$imageFile");
    var task = refUserImage.putFile(imageFile);
    var downloader = refUserImage.getDownloadURL();
    return {"task":task, "url": downloader};

  }

  @override
  Future<Map<String,dynamic>> downloadImage({required File imageFileLocal,  required String downloadPath}) async{
    final storageRef = FirebaseStorage.instance.refFromURL(downloadPath);
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
      return throw("you're not connected");
    }

    try {

      DownloadTask task = storageRef.writeToFile(imageFileLocal);
      return {"task":task};
    } on Exception catch (e) {
      return throw("error on downloading ");
    }
  }

  @override
  Future<Map<String,dynamic>> downloadVideo({required File videoFileLocal, required String downloadPath}) async{
    final storageRef = FirebaseStorage.instance.refFromURL(downloadPath);
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
     return throw("you're not connected");
    }

    try {
      DownloadTask task = storageRef.writeToFile(videoFileLocal);
      return {"task":task};
    } on Exception catch (e) {
      return throw("error on downloading ");
    }
  }

  @override
  Future<List<String>> getImages()async {
    final storageRef = FirebaseStorage.instance.ref();
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
      return throw("you're not connected");
    }
    var refList = await storageRef.child("images").listAll();
    List<String> list =[];

    for(var prefix in refList.prefixes){
      var refList2 = await prefix.listAll();
      for(var item in refList2.items){
          list.add(await item.getDownloadURL());
      }
    }

    return list;
  }

  @override
  Future<List<String>> getVideos() async{
    final storageRef = FirebaseStorage.instance.ref();
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
      return throw("you're not connected");
    }
    var refList = await storageRef.child("videos").listAll();
    List<String> list =[];

    for(var item in refList.items){
        list.add(await item.getDownloadURL());
    }

    return list;
  }

  @override
  Future<void> deleteImage({required String downloadPath}) async {
    final storageRef = FirebaseStorage.instance.refFromURL(downloadPath);
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
       throw("you're not connected");
    }
   storageRef.delete();
  }

  @override
  Future<void> deleteVideos({required String downloadPath}) async{
    final storageRef = FirebaseStorage.instance.refFromURL(downloadPath);
    bool connected = FirebaseAuth.instance.currentUser == null;
    if(connected){
      throw("you're not connected");
    }
    storageRef.delete();
  }

  @override
  Future<List<String>> getVideosPage() {
    // TODO: implement getVideosPage
    throw UnimplementedError();
  }



}