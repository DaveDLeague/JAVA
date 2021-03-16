class QuizDisplay {
  class Quiz {
    String question;
    ArrayList<String> choices;
    int correctAnswer;

    Quiz(String question, int correctAnswer, String... choices) {
      this.question = question;
      this.correctAnswer = correctAnswer;
      for (String s : choices) {
        this.choices.add(s);
      }
    }

    Quiz(String question, int correctAnswer, ArrayList<String> choices) {
      this.question = question;
      this.correctAnswer = correctAnswer;
      this.choices = choices;
    }

    void render() {
    }
  }
}
