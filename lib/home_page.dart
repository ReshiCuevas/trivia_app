import 'package:flutter/material.dart';
import 'profile.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Welcome to the Triviattl',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildTile(context, 'Quiz diario', Colors.blue, Icons.category),
                _buildTile(context, 'Partidas', Colors.green, Icons.gamepad),
                _buildTile(context, 'Perfil', Colors.orange, Icons.person), // Updated tile
                _buildTile(context, 'Crear quiz', Colors.purple, Icons.create),
                _buildTile(
                    context, 'Leaderboards', Colors.red, Icons.leaderboard),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
      BuildContext context, String title, Color color, IconData iconData) {
    return InkWell(
      onTap: () {
        if (title == 'Perfil') {
          Navigator.pushNamed(context, '/Perfil');
        } else {
          Navigator.pushNamed(context, '/$title');
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: color,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(iconData),
          ),
        ),
      ),
    );
  }
}

class QuizDiarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Diario'),
      ),
      body: Center(
        child: Text('This is the Quiz Diario screen'),
      ),
    );
  }
}

class PartidasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       appBar: AppBar(
        title: Text('Partidas'),
      ),
      body: Center(
        child: Text('This is the Partidas screen'),
      ),
    );
  }
}

class CrearQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Quiz'),
      ),
      body: Center(
        child: Text('This is the Crear Quiz screen'),
      ),
    );
  }
}

class LeaderboardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboards'),
      ),
      body: Center(
        child: Text('This is the Leaderboards screen'),
      ),
    );
  }
}
