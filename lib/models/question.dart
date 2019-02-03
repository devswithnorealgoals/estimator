class Question {
  String text;
  int answer;
  List<int> choices;

  Question() {
    this.text = "Active question";
    this.answer = 4;
    this.choices = [4, 7, 8, 9];
  }

  bool guess(v) {
    if (v != this.answer) {
      return false;
    }

    return true;
  }

}
