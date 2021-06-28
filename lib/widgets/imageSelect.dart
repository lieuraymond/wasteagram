import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/services.dart';
import '../models/posts.dart';
import 'package:intl/intl.dart';

class PostForm extends StatefulWidget {
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  File _image;
  final image = ImagePicker();
  DateTime currentDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final newPost = Posts();
  LocationData locationData;

  void getImage() async{
    final pickedFile = await image.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void upload() async{
    StorageReference storageReference = FirebaseStorage.instance.ref().child(Path.basename(_image.path));
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    newPost.url = await storageReference.getDownloadURL();
    newPost.dateTime = DateTime.now();
    newPost.latitude = locationData.latitude;
    newPost.longitude = locationData.longitude;
    Firestore.instance.collection('posts').add({
      'waste' : newPost.waste,
      'latitude' : newPost.latitude,
      'longitude' : newPost.longitude,
      'date' : newPost.dateTime,
      'url' : newPost.url,
    });
    final DocumentReference postRef = Firestore.instance.document('total/sum');
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      if (postSnapshot.exists) {
        await tx.update(postRef, <String, dynamic>{'totalWaste': postSnapshot.data['totalWaste'] + newPost.waste});
      }
    });
  }

  void getLocation() async{
    var locationService = Location();
    locationData = await locationService.getLocation();
  }
  @override
  Widget build(BuildContext context) {
      if (_image == null){
        getLocation();
        getImage();
        return Center(child: CircularProgressIndicator());
    } else {
        return FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Flexible(
                flex: 1,
                child:  Text('${DateFormat("EEE, yyyy MMM dd").format(DateTime.now())}',
                style: TextStyle(fontSize: 20))
              ),
              Flexible(
                flex: 3,
                child:  Image.file(_image),
              ),
              Flexible(
                flex: 2,
                child:Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Semantics(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: 'Waste Quantity',
                              ),
                              onSaved: (value){
                                newPost.waste = int.parse(value);
                              },
                            keyboardType: TextInputType.number,
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          ),),
                          enabled: true,
                          textField: true,
                          ),
                        ]),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child:Padding(
                  padding: const EdgeInsets.only(top: 8),
                    child: Semantics(
                        child: RaisedButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            upload();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Upload')
                    ),
                    button: true,
                    enabled: true,
                    ),
                ),
              ),

            ],
          ),
        );
    }
  }
}