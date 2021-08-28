import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {

  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic>? navigateTo(String routeName) {
    return Get.toNamed(routeName);
  }


  Future<dynamic>? navigateToWithArg(String routeName, dynamic arg) {
    return Get.toNamed(routeName, arguments: arg);
  }

  Future<dynamic>? getOffAll(String routeName) {
    return Get.offAllNamed(routeName);
  }

  goBack() => Get.back();
}
