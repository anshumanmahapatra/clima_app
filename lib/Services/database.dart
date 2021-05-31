
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class DatabaseMethods with ChangeNotifier {

  String initUserEmail, initName, initUserId, initComplaintPost, initForumPost, initPhotoUrl;
  String get getInitUserName => initName;
  String get getInitUserEmail => initUserEmail;
  String get getInitUserId => initUserId;
  String get getInitPhotoUrl => initPhotoUrl;
  String get getInitComplaintPost => initComplaintPost;
  String get getInitForumPost => initForumPost;


  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future createComplaintCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("Complaints")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future createForumCollection(BuildContext context, dynamic data, String forumId) async {
    return FirebaseFirestore.instance
        .collection("Forum")
        .doc(forumId)
        .set(data);
  }

  Future addUpVotes (BuildContext context, dynamic data, String forumId, String upVoteId ) async {
    return FirebaseFirestore.instance
        .collection("Forum")
        .doc(forumId)
        .collection("UpVotes")
        .doc(upVoteId)
        .set(data);
  }

  Future deleteUpVotes (BuildContext context,  String forumId, String upVoteId) async {
    return FirebaseFirestore.instance
        .collection("Forum")
        .doc(forumId)
        .collection("UpVotes")
        .doc(upVoteId)
        .delete();
  }

  Future addDownVotes (BuildContext context, dynamic data,  String forumId, String downVoteId) async {
    return FirebaseFirestore.instance
        .collection("Forum")
        .doc(forumId)
        .collection("DownVotes")
        .doc(downVoteId)
        .set(data);
  }

  Future deleteDownVotes (BuildContext context,  String forumId, String downVoteId) async {
    return FirebaseFirestore.instance
        .collection("Forum")
        .doc(forumId)
        .collection("DownVotes")
        .doc(downVoteId)
        .delete();
  }


  Future addComments (BuildContext context, dynamic data,  String forumId, String commentId) async {
    return FirebaseFirestore.instance
        .collection("Forum")
        .doc(forumId)
        .collection("Comments")
        .doc(commentId)
        .set(data);
  }


  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      initUserEmail = doc.data()["email"];
      initUserId = doc.data()["userid"];
      initName = doc.data()["name"];
      initPhotoUrl = doc.data()["photoUrl"];
      notifyListeners();
    } );
  }

  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

}