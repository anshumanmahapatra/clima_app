import 'package:clima_app/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumComment extends StatefulWidget {
  final String forumId;

  ForumComment({@required this.forumId});

  @override
  _ForumCommentState createState() => _ForumCommentState();
}

class _ForumCommentState extends State<ForumComment> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Comment"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Forum")
                    .doc(widget.forumId)
                    .collection("Comments")
                    .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length > 0 ? snapshot.data.docs.length : 0,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 24,
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.network(snapshot.data.docs[index]['photoUrl'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.25 - 50,
                                  child: Row(
                                    children: [
                                      Text(snapshot.data.docs[index]['name'],
                                          style: TextStyle(
                                            color: Color(0xFF229062),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      SizedBox(width: 10,),
                                      Text(snapshot.data.docs[index]['comment'],
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                 else {
                   return Center(
                     child: Container(
                       child: Text("Be the First One to Engage with the Post"),
                     ),
                   );
                  }
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5,),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      Provider
                          .of<DatabaseMethods>(context, listen: false)
                          .initPhotoUrl == null
                          ?
                      "https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/johnny.jpg?alt=media&token=d5b9e202-9d66-4fc9-93db-a8dea8587654"
                          :
                      Provider
                          .of<DatabaseMethods>(context, listen: false)
                          .getInitPhotoUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes !=
                                  null ?
                              loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                                  : null,
                            )
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    onSaved: (String value) {
                      comment = value;
                    },
                    validator: (input) {
                      return input.isEmpty ? "Leave a Comment" : null;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    minLines: 1,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xFF229062),
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xFF229062),
                            )),
                        hintText: "Leave a Comment",
                        hintStyle: TextStyle(
                          color: Color(0xFF229062),
                        ),
                    ),
                    maxLength: 300,
                  ),
                ),
              ),
              SizedBox(width: 5,),
              ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Provider.of<DatabaseMethods>(context, listen: false)
                        .addComments(context, {
                      "comment": comment,
                      "userid": Provider
                          .of<DatabaseMethods>(context, listen: false)
                          .getInitUserId,
                      "name": Provider
                          .of<DatabaseMethods>(context, listen: false)
                          .getInitUserName,
                      "photoUrl": Provider
                          .of<DatabaseMethods>(context, listen: false)
                          .initPhotoUrl ==
                          null
                          ? "https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/johnny.jpg?alt=media&token=d5b9e202-9d66-4fc9-93db-a8dea8587654"
                          : Provider
                          .of<DatabaseMethods>(context, listen: false)
                          .getInitPhotoUrl,
                    },
                      widget.forumId,
                      Provider
                          .of<DatabaseMethods>(context, listen: false)
                          .getInitUserName,
                    );
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  primary: Color(0xFF229062),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(width: 5,),
            ],
          )
        ],
      ),
    );
  }
}
