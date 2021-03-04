import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  String id;
  final String title;
  final String content;
  final String imageURL;

  Memo({this.title, this.content, this.imageURL});

  factory Memo.fromJson(Map<String, dynamic> json) => Memo(
      title: json['title'],
      content: json['content'],
      imageURL: json['imageURL']);

  Map<dynamic, dynamic> toJson(Memo memo) => <String, dynamic>{
        'title': memo.title,
        'content': memo.content,
        'imageURL': memo.imageURL,
      };

  factory Memo.fromFirestore(DocumentSnapshot documentSnapshot) {
    Memo memo = Memo.fromJson(documentSnapshot.data());
    memo.id = documentSnapshot.id;
    return memo;
  }
}
