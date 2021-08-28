import 'dart:io';

import 'package:assignment/constant/colors.dart';
import 'package:assignment/constant/controllers.dart';
import 'package:assignment/constant/file_handler.dart';
import 'package:assignment/model/post_model.dart';
import 'package:assignment/router/route_generator.dart';
import 'package:assignment/view/home/widget/app_bar.dart';
import 'package:assignment/view/home/widget/build_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text('Take a picture'),
                    onTap: () async {
                      navigationController.goBack();
                      FileHandler.takePicture()!.then((value) {
                        checkNavigation(value);
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: const Text('Select from gallery'),
                    onTap: () async {
                      navigationController.goBack();
                      FileHandler.getImage()!.then((value) {
                        checkNavigation(value);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void checkNavigation(File file) {
    if (file.path != '') {
      navigationController.navigateToWithArg(uploadScreen, file);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(postController.postList.length);
    return Scaffold(
        appBar: buildAppBar(title: 'PixlePk', ctx: context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _optionsDialogBox,
          icon: const Icon(Icons.add),
          label: const Text('UPLOAD'),
        ),
        body: usingGetX());
  }

  Widget usingGetX() {
    return Obx(() => postController.postList.isEmpty
        ? const Center(
            child: Text(
              'No Post Yet',
              style: TextStyle(
                fontFamily: 'Akira',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
          )
        : ListView.builder(
            itemCount: postController.postList.length,
            itemBuilder: (ctx, index) {
              return BuildCardItem(postModel: postController.postList[index]);
            }));
  }
}
