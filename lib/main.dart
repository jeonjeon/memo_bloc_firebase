import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memo_bloc_firebase/provider/screens/memo_screen.dart';
import 'package:provider/provider.dart';

import 'provider/memo_repository/memo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemoProvider>(
      create: (context) => MemoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MemoScreen(),
      ),
    );
  }
}
