import 'package:flutter/material.dart';
import '../widgets/imageSelect.dart';


class CreatePost extends StatefulWidget {
  static const routeName = '/createPost';
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Semantics(child: PostForm(),
        hint: 'Form to upload a post'),
    );
  }
}