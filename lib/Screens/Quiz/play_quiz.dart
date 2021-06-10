import 'package:clima_app/Constants/quiz_constant.dart';
import 'package:clima_app/HelpingWidgets/option_tile.dart';
import 'package:clima_app/Model/quiz_model.dart';
import 'package:clima_app/Screens/Quiz/quiz_results.dart';
import 'package:flutter/material.dart';

class PlayQuiz extends StatefulWidget {
  final String quizTitle;
  final int quizId;

  PlayQuiz(this.quizId, this.quizTitle);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0, _correct = 0, _incorrect = 0;

class _PlayQuizState extends State<PlayQuiz> {
  List<Map<String, String>> quizData;

  QuestionModel getQuestionModelFromDataSnapshot(int index) {
    QuestionModel questionModel = new QuestionModel();
    if (widget.quizId == 0) {
      quizData = quizQuestionAnswer1;
    } else {
      quizData = quizQuestionAnswer2;
    }
    questionModel.question = quizData[index]["question"];
    questionModel.option1 = quizData[index]["option1"];
    questionModel.option2 = quizData[index]["option2"];
    questionModel.option3 = quizData[index]["option3"];
    questionModel.option4 = quizData[index]["option4"];
    questionModel.correctOption = quizData[index]["option1"];
    questionModel.answered = false;
    return questionModel;
  }

  @override
  void initState() {
    _correct = 0;
    _incorrect = 0;
    total = 5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.quizId);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizTitle),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListWheelScrollView.useDelegate(
        itemExtent: 300,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 5,
          builder: (context, index) {
            return QuizPlayTile(
              questionModel: getQuestionModelFromDataSnapshot(index),
              index: index,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_sharp),
        backgroundColor: Color(0xFF229062),
        onPressed: () {
          String youAre = "";
          if (_correct <= 2) {
            youAre = "A Novice";
          } else if (_correct == 3) {
            youAre = "Lazy to Learn New Things";
          } else {
            youAre = "Highly Knowledgeable";
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                        quizId: widget.quizId,
                        correct: _correct,
                        incorrect: _incorrect,
                        total: total,
                        youAre: youAre,
                      )));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 5,
      child: Container(
          margin: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Q${widget.index + 1} ${widget.questionModel.question}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    if (widget.questionModel.option1 ==
                        widget.questionModel.correctOption) {
                      optionSelected = widget.questionModel.option1;
                      widget.questionModel.answered = true;
                      _correct++;
                      setState(() {});
                    } else {
                      optionSelected = widget.questionModel.option1;
                      widget.questionModel.answered = true;
                      _incorrect++;
                      setState(() {});
                    }
                  }
                },
                child: OptionTile(
                  correctAnswer: widget.questionModel.correctOption,
                  description: widget.questionModel.option1,
                  option: "A",
                  optionSelected: optionSelected,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    if (widget.questionModel.option2 ==
                        widget.questionModel.correctOption) {
                      optionSelected = widget.questionModel.option2;
                      widget.questionModel.answered = true;
                      _correct++;
                      setState(() {});
                    } else {
                      optionSelected = widget.questionModel.option2;
                      widget.questionModel.answered = true;
                      _incorrect++;
                      setState(() {});
                    }
                  }
                },
                child: OptionTile(
                  correctAnswer: widget.questionModel.correctOption,
                  description: widget.questionModel.option2,
                  option: "B",
                  optionSelected: optionSelected,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    if (widget.questionModel.option3 ==
                        widget.questionModel.correctOption) {
                      optionSelected = widget.questionModel.option3;
                      widget.questionModel.answered = true;
                      _correct++;
                      setState(() {});
                    } else {
                      optionSelected = widget.questionModel.option3;
                      widget.questionModel.answered = true;
                      _incorrect++;
                      setState(() {});
                    }
                  }
                },
                child: OptionTile(
                  correctAnswer: widget.questionModel.correctOption,
                  description: widget.questionModel.option3,
                  option: "C",
                  optionSelected: optionSelected,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.questionModel.answered) {
                    if (widget.questionModel.option4 ==
                        widget.questionModel.correctOption) {
                      optionSelected = widget.questionModel.option4;
                      widget.questionModel.answered = true;
                      _correct++;
                      setState(() {});
                    } else {
                      optionSelected = widget.questionModel.option4;
                      widget.questionModel.answered = true;
                      _incorrect++;
                      setState(() {});
                    }
                  }
                },
                child: OptionTile(
                  correctAnswer: widget.questionModel.correctOption,
                  description: widget.questionModel.option4,
                  option: "D",
                  optionSelected: optionSelected,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}
