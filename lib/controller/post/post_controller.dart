import 'dart:io';
import 'package:assignment/constant/controllers.dart';
import 'package:assignment/constant/custom_full_screen_dialog.dart';
import 'package:assignment/constant/custom_snackbar.dart';
import 'package:assignment/controller/post/service/database.dart';
import 'package:assignment/model/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();
  var postList = <PostModel>[].obs;

  UploadTask? task;
  var progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // BINDING STREAM TO MY POST LIST
    postList.bindStream(Database().getAllPost());
  }

  Future uploadPost(PostModel obj, File file) async {
    CustomFullScreenDialog.showDialog();
    task = await Database().uploadFile(obj.title!, file);
    if(task == null) return;

    task!.snapshotEvents.listen((event) {
      progress.value = ((event.bytesTransferred.toDouble()/event.totalBytes.toDouble()) * 100).roundToDouble();
      print(progress);
    });

    final snapshot = await task!.whenComplete(() => debugPrint('File Uploaded'));
    final urlDownload = await snapshot.ref.getDownloadURL();

    Database().uploadPost(obj, urlDownload);

    if(progress.value == 100.0){
      CustomFullScreenDialog.cancelDialog();
      navigationController.goBack();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "File Uploaded",
          message: "Post added successfully",
          backgroundColor: Colors.green);
    }

  }

  deletePost(String uid, String refUrl){
    Database().deletePost(uid, refUrl);
  }

  updatePost(String uid, Map<String, dynamic> updatedMap){
    Database().updatePost(uid, updatedMap);
  }

}