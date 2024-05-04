import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/forget-password/forget_password_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/home/home_screen.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaya App',
      debugShowCheckedModeBanner: false,
      routes: {
        "/" : (context) => HomeScreen()
      },
      
    );
  }
}