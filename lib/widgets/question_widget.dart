import 'package:estimator/models/question.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;

  QuestionWidget(this.question);

  @override
  QuestionState createState() {
    return QuestionState(this.question);
  }
}

class QuestionState extends State<QuestionWidget> {
  Question _question;
  int _startTime;
  int endTime;
  bool _answered;

  QuestionState(this._question);

  @override
  void initState() {
    super.initState();
    this._startTime = new DateTime.now().millisecondsSinceEpoch;
    this._answered = false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    items.add(
      Text(this._question.text),
    );
    for (int choice in this._question.choices) {
      items.add(RaisedButton(
          color: Colors.blue,
          child: Text(choice.toString()),
          onPressed: () => pressBtn(choice)));
    }

    if (this._answered) {
      items.add(Text("Answered in " +
          ((this.endTime - this._startTime) / 1000).toString()));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: items,
    );
  }

  pressBtn(choice) {
    if (this._answered || !this._question.guess(choice)) {
      return;
    }
    setState(() {
      this.endTime = new DateTime.now().millisecondsSinceEpoch;
      this._answered = true;
    });
  }
}
