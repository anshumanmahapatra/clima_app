import 'package:flutter/material.dart';

class ForumLikesDislikes extends StatefulWidget {
  final String title;
  final Widget bodyContent;
  ForumLikesDislikes({@required this.title, @required this.bodyContent});
  @override
  _ForumLikesDislikesState createState() => _ForumLikesDislikesState();
}

class _ForumLikesDislikesState extends State<ForumLikesDislikes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Color(0xFF229062),
          centerTitle: true,
          elevation: 0.0,
        ),
      body: widget.bodyContent,
    );
  }
}
