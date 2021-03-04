import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:memo_bloc_firebase/provider/memo_repository/memo_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddMemoScreen extends StatefulWidget {
  @override
  _AddMemoScreenState createState() => _AddMemoScreenState();
}

class _AddMemoScreenState extends State<AddMemoScreen> {
  String _newMemoTitle;
  String _newMemoContent;
  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print('pickedFile == null ${pickedFile == null}');
    if (pickedFile != null) {
      print('pickedFile == null ${pickedFile == null}');
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {}
  }

  Future<String> uploadFile() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('imagememo/${Path.basename(_image.path)}}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => print('File Uploaded'));
    return await storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoProvider>(
      builder: (context, memoData, child) {
        return Container(
          color: Color(0xff757575),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Add Memo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'title'),
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (newText) {
                    _newMemoTitle = newText;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'content'),
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (newText) {
                    _newMemoContent = newText;
                  },
                ),
                if (_image != null) Image.file(_image),
                TextButton(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(text: 'Photo')
                        ],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                    ),
                    onPressed: getImage),
                TextButton(
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                  ),
                  onPressed: () async {
                    String imageURL;
                    if (_newMemoTitle == null) return false;
                    if (_image != null) {
                      imageURL = await uploadFile();
                    }
                    Provider.of<MemoProvider>(context, listen: false).addMemo(
                        newTaskTitle: _newMemoTitle,
                        content: _newMemoContent,
                        imageURL: imageURL);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
