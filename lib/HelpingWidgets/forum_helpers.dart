import 'package:clima_app/HelpingWidgets/forum_helpers_interact.dart';
import 'package:flutter/material.dart';


class ForumHelpers with ChangeNotifier {

  Widget forumHelpers(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length > 0 ? snapshot.data.docs.length : 0,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 24,
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.network(snapshot.data.docs[index]['profileUrl'],
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
                          child: Text(snapshot.data.docs[index]['name'],
                              style: TextStyle(
                                color: Color(0xFF229062),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 36,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      snapshot.data.docs[index]['title'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 18),
                          blurRadius: 40,
                          spreadRadius: -12,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        snapshot.data.docs[index]['forumUrl'],
                        width: MediaQuery.of(context).size.width - 35,
                        height: 350,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ForumHelpersInteract(forumId: snapshot.data.docs[index]['forumId'],),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width - 36,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        snapshot.data.docs[index]['description'],
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          });
    } else {
      return Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Text(
            "Be the First One To Post to the Forum",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black54,
            ),
          ),
        ),
      );
    }
  }
}
