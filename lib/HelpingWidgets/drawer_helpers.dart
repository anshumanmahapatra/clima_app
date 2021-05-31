import 'package:clima_app/Screens/Article/article_home.dart';
import 'package:clima_app/Screens/Complaint/complaint_home.dart';
import 'package:clima_app/Screens/Home/profile_page.dart';
import 'package:clima_app/Screens/ML/ml_home.dart';
import 'package:clima_app/Screens/Quiz/quiz_home.dart';
import 'package:clima_app/Screens/Forum/forum_home.dart';
import 'package:clima_app/Services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerHelpers with ChangeNotifier {

  showDrawer (BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Color(0xFF229062),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        child:
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    Provider.of<DatabaseMethods>(context, listen : false).initPhotoUrl == null ?
                                    "https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/johnny.jpg?alt=media&token=d5b9e202-9d66-4fc9-93db-a8dea8587654" :
                                    Provider.of<DatabaseMethods>(context, listen : false).getInitPhotoUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null ?
                                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                : null,
                                          )
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                      ),
                      Spacer(),
                      Text("Clima App",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w800)),
                    ]),
              )),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.article,
                  size: 31,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Articles Page',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArticleHome()));
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.forum,
                  size: 31,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 220,
                    child: Text(
                      'Forum',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForumHome()));
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.report_problem,
                  size: 31,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Lodge Complaint',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ComplaintHome()));
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.analytics,
                  size: 31,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 220,
                    child: Text(
                      'Analytics and Machine Learning',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MLHome()));
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.emoji_objects,
                  size: 31,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Take a Quiz',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuizHome()));
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.settings,
                  size: 31,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {},
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              "Privacy Policy",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Terms of Use",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}