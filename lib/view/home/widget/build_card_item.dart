import 'package:assignment/constant/colors.dart';
import 'package:assignment/constant/controllers.dart';
import 'package:assignment/model/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BuildCardItem extends StatefulWidget {
  final PostModel postModel;
  BuildCardItem({Key? key, required this.postModel}) : super(key: key);

  @override
  State<BuildCardItem> createState() => _BuildCardItemState();
}

class _BuildCardItemState extends State<BuildCardItem> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // ready to upload
      Map<String, dynamic> updatedValue = {
        'title' : titleController.text,
        'description' : descriptionController.text,
      };
      postController.updatePost(widget.postModel.id!, updatedValue);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.postModel.title!;
    descriptionController.text = widget.postModel.description!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: CachedNetworkImage(
                imageUrl: widget.postModel.imageUrl!,
                  memCacheHeight: 500,
                  fit: BoxFit.cover,
                  placeholder: (_, val) => const SizedBox(height: 200, child:  Center(child: CircularProgressIndicator(color: darkBlue,),)),
                )),
            Container(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(widget.postModel.title!,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text(widget.postModel.description!,style: TextStyle(
                          fontSize: 14, color: Colors.grey.shade700),
                      textAlign: TextAlign.left),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: editPost,
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'Edit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: displayDeleteDialog,
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'Delete',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent[700],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  editPost() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding:
          const EdgeInsets.all(16),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      title: ElevatedButton(onPressed: _trySubmit, child: const Text('Update'),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  displayDeleteDialog() {
    Get.defaultDialog(
      title: "Delete Post",
      titleStyle: const TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete this post?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: darkBlue,
      onCancel: () {
        navigationController.goBack();
      },
      onConfirm: () {
        navigationController.goBack();
        postController.deletePost(widget.postModel.id!, widget.postModel.imageUrl!);
      },
    );
  }
}
