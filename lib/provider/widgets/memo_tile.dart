import 'package:flutter/material.dart';

class MemoTile extends StatelessWidget {
  final bool isOpen;
  final String title;
  final String content;
  final String imageURL;
  final Function deleteFunction;

  MemoTile(
      {this.isOpen,
      this.title,
      this.content,
      this.imageURL,
      this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "제목: $title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteFunction,
          ),
        ),
        Column(
          children: [
            Text('내용: $content' ?? ''),
            if (imageURL != null) Image.network(imageURL),
          ],
        ),
      ],
    );
  }
}
