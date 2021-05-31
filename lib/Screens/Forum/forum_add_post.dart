import 'package:clima_app/Screens/Forum/forum_home.dart';
import 'package:clima_app/Screens/Forum/forum_upload_pic.dart';
import 'package:clima_app/Services/auth.dart';
import 'package:clima_app/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumAddPost extends StatefulWidget {
  @override
  _ForumAddPostState createState() => _ForumAddPostState();
}

class _ForumAddPostState extends State<ForumAddPost> {
  String title, description;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForumUploadPic()));
                },
                child: Container(
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Provider.of<DatabaseMethods>(context, listen: false)
                                .initForumPost ==
                            null
                        ? Container(
                            width: MediaQuery.of(context).size.width - 25,
                            height: 250,
                            color: Color(0xFF229062),
                            child: Center(
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Image.network(
                            Provider.of<DatabaseMethods>(context, listen: false)
                                .getInitForumPost,
                            width: MediaQuery.of(context).size.width - 25,
                            height: 250,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          color: Color(0xFF229062),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF229062),
                          width: 2,
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF229062),
                            width: 2,
                          ),
                        ),
                      ),
                      maxLength: 100,
                      maxLines: 2,
                      minLines: 1,
                      validator: (val) {
                        return val.isEmpty ? 'Enter Title' : null;
                      },
                      onSaved: (input) {
                        title = input;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Color(0xFF229062),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF229062),
                          width: 2,
                        )),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF229062),
                            width: 2,
                          ),
                        ),
                      ),
                      maxLength: 500,
                      maxLines: 10,
                      minLines: 1,
                      validator: (val) {
                        return val.isEmpty ? 'Enter Description' : null;
                      },
                      onSaved: (input) {
                        description = input;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        primary: Color(0xFF229062),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Provider.of<DatabaseMethods>(context, listen: false)
                              .createForumCollection(
                                  context,
                                  {
                                    "forumId" : Provider.of<Authentication>(context, listen: false).getUserUid,
                                    "profileUrl": Provider.of<DatabaseMethods>(
                                                    context,
                                                    listen: false)
                                                .initPhotoUrl ==
                                            null
                                        ? "https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/johnny.jpg?alt=media&token=d5b9e202-9d66-4fc9-93db-a8dea8587654"
                                        : Provider.of<DatabaseMethods>(context,
                                                listen: false)
                                            .getInitPhotoUrl,
                                    "name": Provider.of<DatabaseMethods>(
                                            context,
                                            listen: false)
                                        .getInitUserName,
                                    'forumUrl': Provider.of<DatabaseMethods>(
                                            context,
                                            listen: false)
                                        .getInitForumPost,
                                    "title": title,
                                    "description": description,
                                  },
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .getUserUid)
                              .whenComplete(() {
                            setState(() {
                              Provider.of<DatabaseMethods>(context,
                                      listen: false)
                                  .initForumPost = null;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForumHome()));
                          });
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
