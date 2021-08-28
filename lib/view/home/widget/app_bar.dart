import 'package:flutter/material.dart';


AppBar buildAppBar({required String title, required BuildContext ctx}){
  return AppBar(
    iconTheme: Theme.of(ctx).iconTheme,
    title: Text(title, style: const TextStyle(
      fontFamily: 'Akira',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),),
    centerTitle: true,
    elevation: 0,
  );
}