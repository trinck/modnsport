import 'dart:io';

abstract class StorageRepositoryFirebase{

  Future<Map<String,dynamic>> uploadVideo({required File videoFile});
  Future<List<String>> getVideos();
  Future<List<String>> getVideosPage();
  Future<void> deleteVideos({required String downloadPath});
  Future<void> deleteImage({required String downloadPath});
  Future<List<String>> getImages();
  Future<Map<String,dynamic>> downloadVideo({required File videoFileLocal, required String downloadPath});
  Future<Map<String,dynamic>> downloadImage({required File imageFileLocal,  required String downloadPath});
  Future<Map<String,dynamic>> uploadImage({required File imageFile, bool admin= false});
  Future<Map<String,dynamic>> adminUploadImage({required File imageFile});

}