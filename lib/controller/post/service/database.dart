import 'dart:io';
import 'package:assignment/constant/controllers.dart';
import 'package:assignment/constant/custom_full_screen_dialog.dart';
import 'package:assignment/constant/custom_snackbar.dart';
import 'package:assignment/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Database {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static const String postCollection = 'post';

  Future<UploadTask?> uploadFile(
    String fileName,
    File file,
      ) async {
    final ref = _firebaseStorage
        .ref(postCollection)
        .child(fileName);

    try {
      return ref.putFile(file);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void uploadPost(PostModel post,String downloadLink) async {
    try{
      await _fireStore.collection(postCollection).doc().set({
        'title' : post.title,
        'description' : post.description,
        'imageUrl' : downloadLink,
        'createdAt' : Timestamp.now(),
      });
    }catch(e){
      debugPrint(e.toString());
      navigationController.goBack();
      navigationController.goBack();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "An Error has occurred",
          message: e.toString(),
          backgroundColor: Colors.red);
    }
  }


  Stream<List<PostModel>> getAllPost() {
    return _fireStore
        .collection(postCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      List<PostModel> retVal = <PostModel>[];
      snapshot.docs.forEach((element) {
        retVal.add(PostModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  void deletePost(String uid, String refUrl){
    CustomFullScreenDialog.showDialog();
    try{
      _firebaseStorage.refFromURL(refUrl).delete().whenComplete((){
        _fireStore.collection(postCollection).doc(uid).delete().whenComplete((){
          CustomFullScreenDialog.cancelDialog();
          CustomSnackBar.showSnackBar(
              context: Get.context,
              title: "Deleted successfully",
              message: "Post deleted",
              backgroundColor: Colors.green);
        });
      });
    }catch(e){
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "An Error has occurred",
          message: e.toString(),
          backgroundColor: Colors.red);
    }
  }

  void updatePost(String uid, Map<String, dynamic> updatedMap){
    CustomFullScreenDialog.showDialog();
    try{
      _fireStore.collection(postCollection).doc(uid).update(updatedMap).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        navigationController.goBack();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Update successful",
            message: "Post updated successfully",
            backgroundColor: Colors.green);
      });
    }catch(e){
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "An Error has occurred",
          message: e.toString(),
          backgroundColor: Colors.red);
    }
  }

}
