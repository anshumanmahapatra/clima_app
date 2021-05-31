import 'package:clima_app/HelpingWidgets/forum_helpers.dart';
import 'package:clima_app/Screens/Forum/forum_add_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumHome extends StatefulWidget {
  @override
  _ForumHomeState createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forum"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Forum").snapshots(),
          builder: (context, snapshot) {
              return Provider.of<ForumHelpers>(context, listen: false).forumHelpers(context, snapshot);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box_outlined, color: Colors.white,),
        backgroundColor: Color(0xFF229062),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ForumAddPost()));
        },
      ),
    );
  }
}
