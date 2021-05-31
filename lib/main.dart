import 'package:clima_app/HelpingWidgets/auth_helpers.dart';
import 'package:clima_app/HelpingWidgets/drawer_helpers.dart';
import 'package:clima_app/HelpingWidgets/forum_helpers.dart';
import 'package:clima_app/Screens/Auth/start.dart';
import 'package:clima_app/Screens/Home/home.dart';
import 'package:clima_app/Services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Auth/sign_in_page.dart';
import 'Screens/Auth/sign_up_page.dart';
import 'HelpingWidgets/forum_upvotes_downvotes.dart';
import 'Services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: <String,WidgetBuilder> {
          "signIn" :(BuildContext context) => SignIn(),
          "signUp" :(BuildContext context) => SignUp(),
          "start" : (BuildContext context) => Start(),
        },
      ),
      providers:
      [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => AuthHelpers()),
        ChangeNotifierProvider(create: (_) => DatabaseMethods()),
        ChangeNotifierProvider(create: (_) => DrawerHelpers()),
        ChangeNotifierProvider(create: (_) => ForumHelpers()),
        ChangeNotifierProvider(create: (_) => ForumUpVotesDownVotes()),
      ],
    );
  }
}
