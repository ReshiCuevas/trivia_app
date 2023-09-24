import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TriviaScreen(),
    );
  }
}

class TriviaScreen extends StatefulWidget {
  @override
  _TriviaScreenState createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  List<String?> userAnswers = List.filled(10, null);
  TextEditingController answerController = TextEditingController();

  Future<void> fetchQuestions() async {
    final response =
        await http.get(Uri.parse('https://jservice.io/api/random?count=10'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        questions = jsonData.map((item) {
          return {
            'category': item['category']['title'],
            'question': item['question'],
            'options': List<String>.from(item['options'] ?? []),
            'correctAnswer': item['correct_answer'],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  void answerQuestion(String answer) {
    userAnswers[currentQuestionIndex] = answer;
    if (answer == questions[currentQuestionIndex]['correctAnswer']) {
      correctAnswers++;
    }
    setState(() {
      if (currentQuestionIndex < 9) {
        currentQuestionIndex++;
      } else {
        showResultsDialog();
      }
    });
  }

  void showResultsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'You answered $correctAnswers out of 10 questions correctly.'),
              Text(
                getResultMessage(correctAnswers),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String getResultMessage(int correctAnswers) {
    if (correctAnswers == 10) {
      return 'Congratulations! You aced the quiz!';
    } else if (correctAnswers >= 7) {
      return 'Well done! You did great!';
    } else {
      return 'Keep practicing. You can do better!';
    }
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia App'),
      ),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Category: ${questions[currentQuestionIndex]['category']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Question ${currentQuestionIndex + 1}/10',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    questions[currentQuestionIndex]['question'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: answerController,
                    decoration: InputDecoration(labelText: 'Your Answer'),
                    onChanged: (value) {
                
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      answerQuestion(answerController.text.trim());
                      answerController.clear();
                    },
                    child: Text(currentQuestionIndex < 9
                        ? 'Next Question'
                        : 'Submit Answers'),
                  ),
                ],
              ),
            ),
    );
  }
}
