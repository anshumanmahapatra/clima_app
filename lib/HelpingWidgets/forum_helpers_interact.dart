import 'package:clima_app/HelpingWidgets/forum_upvotes_downvotes.dart';
import 'package:clima_app/Screens/Forum/forum_comment.dart';
import 'package:clima_app/Screens/Forum/forum_likes_dislikes.dart';
import 'package:clima_app/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumHelpersInteract extends StatefulWidget {
  final forumId;

  ForumHelpersInteract({@required this.forumId});

  @override
  _ForumHelpersInteractState createState() => _ForumHelpersInteractState();
}

class _ForumHelpersInteractState extends State<ForumHelpersInteract> {
  bool isUpVoted;

  @override
  void initState() {
    isUpVoted = null;
    super.initState();
  }

  upVoted() {
    if (isUpVoted == null) {
      Provider.of<DatabaseMethods>(context, listen: false)
          .addUpVotes(
              context,
              {
                "likes": 1,
                "userid": Provider.of<DatabaseMethods>(context, listen: false)
                    .getInitUserId,
                "name": Provider.of<DatabaseMethods>(context, listen: false)
                    .getInitUserName,
                "photoUrl": Provider.of<DatabaseMethods>(context, listen: false)
                            .initPhotoUrl ==
                        null
                    ? "https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/johnny.jpg?alt=media&token=d5b9e202-9d66-4fc9-93db-a8dea8587654"
                    : Provider.of<DatabaseMethods>(context, listen: false)
                        .getInitPhotoUrl,
              },
              widget.forumId,
              Provider.of<DatabaseMethods>(context, listen: false)
                  .getInitUserName)
          .whenComplete(() {
        setState(() {
          isUpVoted = true;
        });
      });
    } else if (isUpVoted == true) {
      Provider.of<DatabaseMethods>(context, listen: false)
          .deleteUpVotes(
              context,
              widget.forumId,
              Provider.of<DatabaseMethods>(context, listen: false)
                  .getInitUserName)
          .whenComplete(() {
        setState(() {
          isUpVoted = null;
        });
      });
    } else {}
  }

  downVoted() {
    if (isUpVoted == null) {
      Provider.of<DatabaseMethods>(context, listen: false)
          .addDownVotes(
              context,
              {
                "dislikes": 1,
                "userid": Provider.of<DatabaseMethods>(context, listen: false)
                    .getInitUserId,
                "name": Provider.of<DatabaseMethods>(context, listen: false)
                    .getInitUserName,
                "photoUrl": Provider.of<DatabaseMethods>(context, listen: false)
                            .initPhotoUrl ==
                        null
                    ? "https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/johnny.jpg?alt=media&token=d5b9e202-9d66-4fc9-93db-a8dea8587654"
                    : Provider.of<DatabaseMethods>(context, listen: false)
                        .getInitPhotoUrl,
              },
              widget.forumId,
              Provider.of<DatabaseMethods>(context, listen: false)
                  .getInitUserName)
          .whenComplete(() {
        setState(() {
          isUpVoted = false;
        });
      });
    } else if (isUpVoted == false) {
      Provider.of<DatabaseMethods>(context, listen: false)
          .deleteDownVotes(
              context,
              widget.forumId,
              Provider.of<DatabaseMethods>(context, listen: false)
                  .getInitUserName)
          .whenComplete(() {
        setState(() {
          isUpVoted = null;
        });
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 36,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Forum")
                      .doc(widget.forumId)
                      .collection("UpVotes")
                      .doc(Provider.of<DatabaseMethods>(context, listen: false)
                          .getInitUserName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: isUpVoted == null
                          ? () => upVoted()
                          : isUpVoted == true
                              ? () => upVoted()
                              : () {},
                      child: Icon(
                        Icons.arrow_upward_sharp,
                        color: isUpVoted == null
                            ? Colors.grey
                            : isUpVoted == true
                                ? Colors.green
                                : Colors.grey,
                        size: isUpVoted == null
                            ? 24
                            : isUpVoted == true
                            ? 26
                            : 24,
                      ),
                    );
                  }),
              SizedBox(
                width: 10,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Forum")
                      .doc(widget.forumId)
                      .collection("UpVotes")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForumLikesDislikes(
                                    title: "Up Votes",
                                    bodyContent:
                                        Provider.of<ForumUpVotesDownVotes>(
                                                context,
                                                listen: false)
                                            .upVotesDownVotes(
                                                context, snapshot))));
                      },
                      child: Text(
                        snapshot.hasData
                            ? snapshot.data.docs.length.toString()
                            : "0",
                        style: TextStyle(
                          fontSize:  isUpVoted == null
                              ? 13
                              : isUpVoted == true
                              ? 14
                              : 13,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Forum")
                      .doc(widget.forumId)
                      .collection("DownVotes")
                      .doc(Provider.of<DatabaseMethods>(context, listen: false)
                          .getInitUserName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return GestureDetector(
                        onTap: isUpVoted == null
                            ? () => downVoted()
                            : isUpVoted == false
                                ? () => downVoted()
                                : () {},
                        child: Icon(
                          Icons.arrow_downward_sharp,
                          color: isUpVoted == null
                              ? Colors.grey
                              : isUpVoted == false
                                  ? Colors.red
                                  : Colors.grey,
                          size: isUpVoted == null
                              ? 24
                              : isUpVoted == false
                              ? 26
                              : 24,
                        ));
                  }),
              SizedBox(
                width: 10,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Forum")
                      .doc(widget.forumId)
                      .collection("DownVotes")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForumLikesDislikes(
                                    title: "Down Votes",
                                    bodyContent:
                                        Provider.of<ForumUpVotesDownVotes>(
                                                context,
                                                listen: false)
                                            .upVotesDownVotes(
                                                context, snapshot))));
                      },
                      child: Text(
                        snapshot.hasData
                            ? snapshot.data.docs.length.toString()
                            : "0",
                        style: TextStyle(
                          fontSize:  isUpVoted == null
                              ? 13
                              : isUpVoted == false
                              ? 14
                              : 13,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForumComment(forumId: widget.forumId,)));
                  },
                  child: Icon(
                    Icons.comment_sharp,
                    color: Colors.grey,
                  )),
              SizedBox(
                width: 10,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Forum")
                      .doc(widget.forumId)
                      .collection("Comments")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                          ? snapshot.data.docs.length.toString()
                          : "0",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
