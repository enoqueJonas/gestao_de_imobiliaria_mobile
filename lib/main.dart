import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/onboarding/onboarding_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/start-screen/start_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: OnBoardingPage()
      ),
    );
  }
}