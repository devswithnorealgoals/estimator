import 'package:estimator/models/question.dart';
import 'package:estimator/services/question_service.dart';
import 'package:estimator/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'question_screen.dart';
import 'leaderboard_screen.dart';



class MainScreen extends StatefulWidget {
  @override
  MainState createState() {
    return MainState();
  }
}

class MainState extends State<MainScreen> {
  QuestionService _questionService = QuestionService();
  Question _question;
  int _currentIndex = 0;
  final List<Widget> _children = [
    QuestionScreenWidget(Colors.white, Text("Combien mesure la Tour Eiffel ?", style: TextStyle(fontSize: 25),)),
    LeaderBoardScreenWidget(Colors.deepOrange)
  ];
  final List<String> _titleList = [
    "Question",
    "Scores"
  ];

  @override
  Widget build(BuildContext context) {
    getActiveQuestion();
    return Scaffold(
        appBar: AppBar(
          title: Text(_titleList[_currentIndex]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.whatshot),
              title: new Text('Question'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.trending_up),
              title: new Text('Leaderboard'),
            )
          ],
          onTap: onTabTapped
        ),
        body: _children[_currentIndex]
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  getActiveQuestion() async {
    Question q = await _questionService.fetchActiveQuestion();
    setState(() {
      _question = q;
    });
  }
}
