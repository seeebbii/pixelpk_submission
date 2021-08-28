import 'package:assignment/constant/colors.dart';
import 'package:assignment/constant/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFullScreenDialog {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: Obx(() => Center(
          child: CircularProgressIndicator(value: postController.progress.value, color: darkBlue,),
        )),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: darkBlue.withOpacity(.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}