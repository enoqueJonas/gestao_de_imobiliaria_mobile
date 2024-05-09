import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'database/firebase_options.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/forget-password/forget_password_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/home/home_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/login/login_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/login/signup_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/start-screen/start_page.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
