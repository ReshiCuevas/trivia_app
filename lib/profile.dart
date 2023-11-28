import 'package:flutter/material.dart';

void main() {
  runApp(MyTriviaApp());
}

class MyTriviaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), routes: {
      '/Perfil': (context) => PerfilScreen(),
    });
  }
}

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
              'Welcome to Triviathlon',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(
                    'assets/profile_icon.png'), // Replace with actual image
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Username: RandomName123',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Ranked #1',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Action when "Cambiar foto de perfil" is pressed
                  },
                  child: Text('Cambiar foto de perfil'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Action when "Cambiar contraseña" is pressed
                  },
                  child: Text('Cambiar contraseña'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Action when "Cerrar sesión" is pressed
                  },
                  child: Text('Cerrar sesión'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
