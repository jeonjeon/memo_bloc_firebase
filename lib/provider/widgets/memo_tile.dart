import 'package:flutter/material.dart';

class MemoTile extends StatefulWidget {
  bool isOpen = false;
  final String title;
  final String content;
  final String imageURL;
  final Function deleteFunction;

  MemoTile({this.title, this.content, this.imageURL, this.deleteFunction});

  @override
  _MemoTileState createState() => _MemoTileState();
}

class _MemoTileState extends State<MemoTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
          widget.isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
      onExpansionChanged: (isOpen) {
        setState(() {
          widget.isOpen = isOpen;
        });
      },
      title: Text(
        "제목: ${widget.title}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: widget.deleteFunction,
      ),
      children: [
        Text('내용: ${widget.content ?? ''}'),
        if (widget.imageURL != null) Image.network(widget.imageURL),
      ],
    );
  }
}
