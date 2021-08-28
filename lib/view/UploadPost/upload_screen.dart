import 'dart:io';
import 'package:assignment/constant/controllers.dart';
import 'package:assignment/model/post_model.dart';
import 'package:assignment/view/home/widget/app_bar.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  final File imageSelected;
  const UploadScreen({Key? key, required this.imageSelected}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // ready to upload
      setState(() {});
      postController.uploadPost(PostModel(title: titleController.text, description: descriptionController.text), widget.imageSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Upload Post', ctx: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 200, width: double.infinity, child: Image.file(widget.imageSelected, fit: BoxFit.contain,)),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required *';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: descriptionController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required *';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8,),
                ListTile(
                  title: ElevatedButton(onPressed: _trySubmit, child: const Text('Upload'),),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
