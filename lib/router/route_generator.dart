// STATIC ROUTES NAME
import 'dart:io';

import 'package:assignment/view/UploadPost/upload_screen.dart';
import 'package:assignment/view/home/home_screen.dart';
import 'package:assignment/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

const String initialRoute = '/';
const String homeScreen = '/homeScreen';
const String uploadScreen = '/uploadScreen';


// ignore: todo
// TODO : ROUTES GENERATOR CLASS THAT CONTROLS THE FLOW OF NAVIGATION/ROUTING

class RouteGenerator {

  // FUNCTION THAT HANDLES ROUTING
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {

    dynamic arg = settings.arguments;

    switch (settings.name) {
      case initialRoute:
        return _getPageRoute(const SplashScreen());
      case homeScreen:
        return _getPageRoute(HomeScreen());
      case uploadScreen:
        return _getPageRoute(UploadScreen(imageSelected: arg,));
      default:
        return _errorRoute();
    }
  }

  // FUNCTION THAT HANDLES NAVIGATION
  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(builder: (ctx) => child);
  }

  // 404 PAGE
  static PageRoute _errorRoute() {
    return MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('ERROR 404: Not Found'),
        ),
      );
    });
  }
}
