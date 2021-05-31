import 'package:clima_app/Constants/quiz_constant.dart';
import 'package:clima_app/Screens/Quiz/play_quiz.dart';
import 'package:flutter/material.dart';

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {

  List<Map<String, String>> quizData = quizGeneralData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Quiz"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: ListView.builder(
                  itemCount: quizData.length,
                    itemBuilder: (context, index) {
                      return QuizTile(
                          imgUrl: quizData[index]['imgUrl'],
                          title: quizData[index]['title'],
                          desc: quizData[index]['desc'],
                          quizId: index);
                    }),
              ) 
          )
        ],
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl, title, desc;
      final int quizId;

  QuizTile(
      {@required this.imgUrl,
        @required this.title,
        @required this.desc,
        @required this.quizId});


  @override
  Widget build(BuildContext context) {

    print(quizId);

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlayQuiz(quizId, title)));
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

