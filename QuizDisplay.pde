import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JOptionPane;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.GridLayout;
import java.awt.Color;

final char[] QUIZ_CHOICE = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};

class QuizDisplay implements ActionListener {
  class Question {
    String question;
    String explanation;
    String[] choices;
    int[] answers;
    JCheckBox[] currentlySelectedAnswers;
  }

  JFrame window = new JFrame();
  JPanel panel = new JPanel();
  JLabel label = new JLabel("Question");
  JButton nextQuestion = new JButton("Next");
  JButton prevQuestion = new JButton("Previous");
  JButton submit = new JButton("Submit");

  Question[] questions;
  int currentQuestion;
  boolean reviewMode;

  QuizDisplay() {
    nextQuestion.addActionListener(this);
    prevQuestion.addActionListener(this);
    submit.addActionListener(this);

    window.add(panel);
    window.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
    window.setVisible(true);

    buildTestQuiz();  
    currentQuestion = 0;
    displayCurrentQuestion();
  }

  void buildTestQuiz() {
    int totalQuestions = (int)random(4, 9);
    questions = new Question[totalQuestions];
    for (int i = 0; i < totalQuestions; i++) {
      questions[i] = new Question();
      questions[i].question = "This is question " + (i + 1) + ". The answers are ";
      questions[i].explanation = "The answer is this because of this";

      int totalChoices = (int)random(4, 8);
      int totalCorrect = (int)random(1, totalChoices);
      questions[i].choices = new String[totalChoices];
      questions[i].currentlySelectedAnswers = new JCheckBox[totalChoices];
      questions[i].answers = new int[totalCorrect];
      ArrayList<Integer> choices = new ArrayList<Integer>();
      for (int j = 0; j < totalChoices; j++) {
        questions[i].choices[j] = "This is choice " + QUIZ_CHOICE[j];
        choices.add(j);
        questions[i].currentlySelectedAnswers[j] = new JCheckBox();
      }
      for (int j = 0; j < totalCorrect; j++) {
        questions[i].answers[j] = choices.remove((int)random(choices.size())); 
        questions[i].question += QUIZ_CHOICE[questions[i].answers[j]] + ", ";
      }
    }
  }

  void displayCurrentQuestion() {
    Question q = questions[currentQuestion];
    if (currentQuestion == 0) {
      prevQuestion.setEnabled(false);
    } else if (currentQuestion > 0) {
      prevQuestion.setEnabled(true);
    }
    if (currentQuestion < questions.length - 1) {
      nextQuestion.setEnabled(true);
    } else {
      nextQuestion.setEnabled(false);
    }


    window.remove(panel);
    panel = new JPanel();
    panel.setLayout(new GridLayout(26, 1));
    panel.add(new JLabel("Question #" + (currentQuestion + 1) + " out of " + questions.length));
    panel.add(new JLabel(q.question));
    for (int i = 0; i < q.choices.length; i++) {
      JPanel mp = new JPanel();
      mp.add(new JLabel("" + QUIZ_CHOICE[i]));
      mp.add(q.currentlySelectedAnswers[i]);
      mp.add(new JLabel(q.choices[i]));
      if (reviewMode) {
        q.currentlySelectedAnswers[i].setEnabled(false);
        for (int j = 0; j < q.answers.length; j++) {
          if (i == q.answers[j]) {
            mp.setOpaque(true);
            mp.setBackground(Color.GREEN);
            break;
          }
        }
      }
      panel.add(mp);
    }
    if (reviewMode) {
      panel.add(new JLabel(q.explanation));
    }
    panel.add(prevQuestion);
    panel.add(nextQuestion);
    panel.add(submit);
    window.add(panel);
    window.pack();
  }

  void grade() {
    //needs competing
    JOptionPane.showMessageDialog(null, "Good Job! You passed!");
  }

  public void actionPerformed(ActionEvent e) {
    JButton b = (JButton)e.getSource();
    if (b == prevQuestion) {
      if (currentQuestion > 0) {
        currentQuestion--;
        displayCurrentQuestion();
      }
    } else if (b == nextQuestion) {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        displayCurrentQuestion();
      }
    } else if (b == submit) {
      if (reviewMode) {
        int confirm = JOptionPane.showConfirmDialog(null, "Are you sure you want to end the review.", "End review?", JOptionPane.YES_NO_OPTION);
        if (confirm == JOptionPane.YES_OPTION) {
          window.dispose();
          if(currentWorld < worlds.length){
            currentWorld++;
          }
          worlds[currentWorld].build();
          currentState = GameStates.WORLD_MAP_STATE;
        }
      } else {
        int confirm = JOptionPane.showConfirmDialog(null, "Are you sure you want to submit the test? There is no going back from here.", "Submit quiz?", JOptionPane.YES_NO_OPTION);
        if (confirm == JOptionPane.YES_OPTION) {
          grade();
          reviewMode = true;
          currentQuestion = 0;
          submit.setText("End Review");
          displayCurrentQuestion();
        }
      }
    }
  }
}
