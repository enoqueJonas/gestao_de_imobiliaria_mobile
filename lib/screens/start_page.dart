import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/onboarding_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StarScreen();
}

class _StarScreen extends State<StartScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    });
  }

/*
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);
  }
  */
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
        Color.fromRGBO(8, 146, 192, 0.87),
        Color.fromRGBO(26, 147, 192, 1),
      ])),
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 80,
          ),
          Text(
            'KAYA',
            style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
