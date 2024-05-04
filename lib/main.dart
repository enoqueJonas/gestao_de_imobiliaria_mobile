import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/forget-password/forget_password_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/login/login_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/login/signup_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/onboarding/onboarding_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/start-screen/start_page.dart';

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
        '/': (context) => const StartScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUp(),
        '/forgetpassword': (context) => const ForgetPasswordScreen(),
      },
    );
  }
}
