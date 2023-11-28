import 'package:flutter/material.dart';
import 'home_page.dart'; // Assuming the screens are imported from another file
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      initialRoute: '/HomePage', // Set initial route to HomePage
      onGenerateRoute: ScreenRouter.generateRoute,
    );
  }
}

class ScreenRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/HomePage':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/QuizDiario':
        return MaterialPageRoute(builder: (_) => QuizDiarioScreen());
      case '/Partidas':
        return MaterialPageRoute(builder: (_) => PartidasScreen());
      case '/Perfil':
        return MaterialPageRoute(builder: (_) => PerfilScreen());
      case '/CrearQuiz':
        return MaterialPageRoute(builder: (_) => CrearQuizScreen());
      case '/Leaderboards':
        return MaterialPageRoute(builder: (_) => LeaderboardsScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
