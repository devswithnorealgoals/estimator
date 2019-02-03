import 'package:estimator/models/question.dart';
import 'package:estimator/services/question_service.dart';
import 'package:estimator/widgets/question_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  MainState createState() {
    return MainState();
  }
}

class MainState extends State<MainScreen> {
  QuestionService _questionService = QuestionService();
  Question _question;

  @override
  Widget build(BuildContext context) {
    getActiveQuestion();
    return Scaffold(
        appBar: AppBar(
          title: Text('Main'),
        ),
        body: new Center(
          child: _question == null
              ? Text("No question")
              : QuestionWidget(_question),
        ));
  }

  getActiveQuestion() async {
    Question q = await _questionService.fetchActiveQuestion();
    setState(() {
      _question = q;
    });
  }
}
