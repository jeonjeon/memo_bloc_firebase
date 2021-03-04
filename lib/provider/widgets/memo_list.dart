import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memo_bloc_firebase/provider/memo_repository/memo.dart';
import 'package:memo_bloc_firebase/provider/memo_repository/memo_provider.dart';
import 'package:provider/provider.dart';

import 'memo_tile.dart';

class MemoList extends StatelessWidget {
  List<Memo> memos;
  @override
  Widget build(BuildContext context) {
    final memoProvider = Provider.of<MemoProvider>(context);
    return StreamBuilder(
      stream: memoProvider.fetchMemoAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          memos = snapshot.data.docs
              .map((document) => Memo.fromFirestore(document))
              .toList();
          return ListView.builder(
            itemCount: memos.length,
            itemBuilder: (context, index) {
              return MemoTile(
                title: memos[index].title,
                content: memos[index].content,
                imageURL: memos[index].imageURL,
                deleteFunction: () => showDialog(
                    context: context,
                    builder: (BuildContext) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        content: Text('삭제하시겠습니까?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                memoProvider.deleteTask(memos[index]);
                                Navigator.pop(context);
                              },
                              child: Text('확인')),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('취소')),
                        ],
                      );
                    }),
              );
            },
          );
        } else {
          return Container(
              width: double.infinity,
              child: Center(
                child: Text('Loading now'),
              ));
        }
      },
    );
  }
}
