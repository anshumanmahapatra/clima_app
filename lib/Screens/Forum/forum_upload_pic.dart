import 'dart:io';

import 'package:clima_app/Screens/Forum/forum_add_post.dart';
import 'package:clima_app/Services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';


class ForumUploadPic extends StatefulWidget {

  @override
  _ForumUploadPicState createState() => _ForumUploadPicState();
}

class _ForumUploadPicState extends State<ForumUploadPic> {
  UploadTask task;
  File _imageFile;

  Future pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    if(pickedFile == null) return;
    final path = pickedFile.path;

    setState(() {
      _imageFile = File(path);
    });
  }

  Future uploadImageToFirebase() async {

    String fileName = path.basename(_imageFile.path);
    final destination = 'files/$fileName';

    task = DatabaseMethods.uploadFile(destination, _imageFile);

    TaskSnapshot taskSnapshot = await task.whenComplete(() {});
    final urlDownload = await taskSnapshot.ref.getDownloadURL().whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ForumAddPost()));
    });

    Provider.of<DatabaseMethods>(context, listen: false).initForumPost =
        urlDownload;
    print("Download Url of Forum Picture:");
    print(Provider.of<DatabaseMethods>(context, listen: false)
        .getInitForumPost);

  }

  @override
  Widget build(BuildContext context) {
    final fileName =
    _imageFile != null ? path.basename(_imageFile.path) : 'No Image Selected';
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Picture"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.3,
            ),
            ElevatedButton(
              child: Row(
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding:
                EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                primary: Color(0xFF229062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                pickImage(ImageSource.camera);
              },
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              child: Row(
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding:
                EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                primary: Color(0xFF229062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              fileName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Row(
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Upload',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                primary: Color(0xFF229062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                uploadImageToFirebase();
              },
            ),
          ],
        ),
      ),
    );
  }
}
