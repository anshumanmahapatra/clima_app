import 'package:flutter/material.dart';

class ForumUpVotesDownVotes with ChangeNotifier {

  Widget upVotesDownVotes (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                    child: Text(snapshot.data.docs[index]['name'],
                        style: TextStyle(
                          color: Color(0xFF229062),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                  )
                ],
              ),
            );
          });
    } else {
      return Center(
        child: Container(
          child: Text("Be the First One to Engage with the Post"),
        ),
      );
    }
  }
}