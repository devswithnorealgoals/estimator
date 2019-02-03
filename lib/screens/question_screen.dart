import 'package:flutter/material.dart';
import 'package:estimator/widgets/question_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionScreenWidget extends StatelessWidget {
  final Color color;
  final Text question;

  QuestionScreenWidget(this.color, this.question);

  answered() {
    print(_currentAnswer);
  }
  String _currentAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('questions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('No available question... please wait for next one');
          return Container(
            padding: EdgeInsets.all(20),
            color: Colors.white24,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(snapshot.data.documents[1]['question'], style: TextStyle(fontSize: 30),),
                  TextField(
                    decoration: InputDecoration(labelText: 'Entrez la réponse'),
                    style: TextStyle(fontSize: 30, color: Colors.black  ),
                    onChanged: (text) {
                      _currentAnswer = text;
                    },
                  ),
                  FlatButton(
                      onPressed: answered,
                      child: Text("Valider"),
                      color: Colors.blueAccent,
                      textTheme: ButtonTextTheme.accent,
                      textColor: Colors.white,
                    )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
