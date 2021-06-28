import 'package:flutter/material.dart';
import '../models/posts.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Details extends StatefulWidget {
  static const routeName = '/details';
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Widget build(BuildContext context) {
    final Posts post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
      ),
      body: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          Flexible(
          flex: 1,
          child:  Text('${DateFormat("EEE, yyyy MMM dd").format(post.dateTime)}',
              style: TextStyle(fontSize: 20))
      ),
            Flexible(
              flex: 3,
              child:  Image.network(post.url),
            ),
            Flexible(
                flex: 3,
                child:  Text('${post.waste} items',
                    style: TextStyle(fontSize: 20))
            ),
            Flexible(
              flex: 1,
              child:  Text('${post.latitude}, ${post.longitude}',
                  style: TextStyle(fontSize: 16))
            ),
          ]),
    ));
  }
}