import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {

  String? id;
  String? title;
  String? description;
  String? imageUrl;
  Timestamp? createdAt;


  PostModel({this.id, this.title, this.description, this.imageUrl});

  PostModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    title = doc['title'];
    description = doc['description'];
    imageUrl = doc['imageUrl'];
    createdAt = doc['createdAt'];

  }

  // Map<String, dynamic> toJson() => {'id':id, 'name':name };
}