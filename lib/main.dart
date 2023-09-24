import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      home: TriviaScreen(),
    );
  }
}

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  _TriviaScreenState createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  String question = '';
  String correctAnswer = '';
  String userAnswer = '';
  bool isCorrect = false;

  Future<void> fetchRandomQuestion() async {
    final response =
        await http.get(Uri.parse('https://jservice.io/api/random'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)[0];
      setState(() {
        question = jsonData['question'];
        correctAnswer = jsonData['answer'];
        userAnswer = '';
        isCorrect = false;
      });
    }
  }

  void checkAnswer() {
    if (userAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
      setState(() {
        isCorrect = true;
      });
    } else {
      setState(() {
        isCorrect = false;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Correct' : 'Incorrect'),
          content: Text(isCorrect
              ? 'Congratulations! Your answer is correct.'
              : 'Sorry, your answer is incorrect.'),
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

  @override
  void initState() {
    super.initState();
    fetchRandomQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Question:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              question,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  userAnswer = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Your Answer',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkAnswer,
              child: Text('Submit Answer'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchRandomQuestion,
        tooltip: 'New Question',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
