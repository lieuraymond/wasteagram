import 'package:flutter/material.dart';
import '../models/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class ListScreen extends StatefulWidget {
  static const routeName = '/listScreen';
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final postDetails = Posts();
  @override
  void initState(){
    super.initState();
    setState(() {

    });
}
  Widget build(BuildContext context){
 /*   var totalWaste;
    void getTotal() async{
      Firestore.instance.collection("total").document('sum').get().then((value){
      setState(() {
        totalWaste = (value.data['totalWaste']);
        print(totalWaste);
      });
    });}
    if (totalWaste == null){
      getTotal();
      return CircularProgressIndicator();
    } else {*/
    return Scaffold(
      appBar:  AppBar(
        title: Text('Wasteagram'),
      ),
      body:  StreamBuilder(
        stream: Firestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
        builder: (content, snapshot){
          if (snapshot.hasData && !snapshot.data.documents.isEmpty){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                var post = snapshot.data.documents[index];
                return Semantics(
                    child: ListTile(
                  title: Text('${DateFormat("EEEE, MMMM dd, yyyy").format(post['date'].toDate())}'),
                  trailing: Text(post['waste'].toString()),
                    onTap: () {
                    postDetails.longitude = post['longitude'];
                    postDetails.latitude = post['latitude'];
                    postDetails.waste = post['waste'];
                    postDetails.url = post['url'];
                    postDetails.dateTime = post['date'].toDate();
                      Navigator.of(context).pushNamed('/details', arguments: postDetails);
                    },
                ),
                onTapHint: 'View details',
                );
              }
            );
          } else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: Semantics(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/createPost');
          },
          tooltip: 'Add Post',
          child: const Icon(Icons.add),
        ),
        onTapHint: 'Opens gallery and creates a post',
        enabled: true,
      ),
    );
  }}
//}