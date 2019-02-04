import 'package:flutter/material.dart';
// import 'package:estimator/widgets/question_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

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
        if (!snapshot.hasData)
          return Text('No available question... please wait for next one');
        return Container(
          padding: EdgeInsets.all(20),
          color: Colors.white24,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  snapshot.data.documents[1]['question'],
                  style: TextStyle(fontSize: 30),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Entrez la réponse'),
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  onChanged: (text) {
                    _currentAnswer = text;
                  },
                ),
                FlatButton(
                  onPressed: () async {
                    try {
                      final dynamic resp = await CloudFunctions.instance.call(
                        functionName: 'answered',
                        parameters: <String, dynamic>{
                          'message': 'hello world!',
                          'answer': _currentAnswer,
                        },
                      );
                      print(resp);
                    } on CloudFunctionsException catch (e) {
                      print('caught firebase functions exception');
                      print(e.code);
                      print(e.message);
                      print(e.details);
                    } catch (e) {
                      print('caught generic exception');
                      print(e);
                    }
                  },
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
    ));
  }
}
