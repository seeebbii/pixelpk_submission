import 'dart:async';

import 'package:assignment/constant/colors.dart';
import 'package:assignment/constant/controllers.dart';
import 'package:assignment/router/route_generator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            () => navigationController.getOffAll(homeScreen));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: darkBlue,
      body: Center(
        child: FlutterLogo(size: 100,),
      ),
    );
  }
}
