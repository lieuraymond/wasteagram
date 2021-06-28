import 'package:flutter/material.dart';
import 'screens/create_Post.dart';
import 'screens/details.dart';
import 'screens/list_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      home: ListScreen(),
      routes: {
        CreatePost.routeName: (context) =>CreatePost(),
        Details.routeName: (context) =>Details(),
      },
    );
  }
}
