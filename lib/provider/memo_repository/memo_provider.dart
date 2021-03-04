import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'memo.dart';

class MemoProvider extends ChangeNotifier {
  CollectionReference reference;

  MemoProvider() {
    reference = FirebaseFirestore.instance.collection('memo');
  }

  Stream<QuerySnapshot> fetchMemoAsStream() {
    return reference.snapshots();
  }

  Future<int> get taskCount async {
    return await reference.snapshots().length;
  }

  void addMemo({String newTaskTitle, String content, String imageURL}) {
    final memo =
        Memo(title: newTaskTitle, content: content, imageURL: imageURL);
    reference.add(memo.toJson(memo));
  }

  void deleteTask(Memo memo) {
    reference.doc(memo.id).delete();
  }
}
