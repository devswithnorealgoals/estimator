import 'package:estimator/models/question.dart';

class QuestionService {
  Future<Question> fetchActiveQuestion() {
    return Future<Question>.value(Question());
  }
}
