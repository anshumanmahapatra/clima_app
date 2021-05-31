import '../HelpingWidgets/auth_helpers.dart';
import 'database.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Authentication with ChangeNotifier {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  String userUid;
  String get getUserUid => userUid;

  Future logIntoAccount (BuildContext context, String email, String password) async{
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      userUid = user.uid;
      print(userUid);
    } catch(e) {
      Provider.of<AuthHelpers>(context, listen: false).showErrorMessage(context, e.toString());
    }
    notifyListeners();
  }

  Future createAccount (BuildContext context, String email, String name, String password) async{
    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      userUid = user.uid;
      print(userUid);
    } catch (e) {
      Provider.of<AuthHelpers>(context, listen: false).showErrorMessage(context, e.toString());
    }
    notifyListeners();
  }


  Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken
        );

        UserCredential result = await firebaseAuth.signInWithCredential(credential);
        User user = firebaseAuth.currentUser;
        userUid = user.uid;
        print(user.uid);
        User userDetails = result.user;

        if(result != null) {
          Provider.of<DatabaseMethods>(context, listen: false)
              .createUserCollection(context, {
            "userid" : userDetails.uid,
            "email" : userDetails.email,
            "name" : userDetails.displayName,
            "photoUrl" : userDetails.photoURL,
          });
          Navigator.pushReplacementNamed(context, "/");
        }
      }
    } catch(e) {
      Provider.of<AuthHelpers>(context, listen: false).showErrorMessage(context, e.toString());
    }
    notifyListeners();
  }

  Future signOut() async{
    User user = firebaseAuth.currentUser;
    print(user.providerData[0].providerId);
    if(user.providerData[0].providerId == 'google.com') {
      await googleSignIn.disconnect();
    }
    await firebaseAuth.signOut();
    return Future.value(true);
  }

}




