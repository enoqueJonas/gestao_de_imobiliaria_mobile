import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestao_de_imobiliaria_mobile/login/login_screen.dart';
import 'database/firebase_options.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/home/home_screen.dart';
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

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, AsyncSnapshot<User?> snapshot){ 

          if(snapshot.connectionState == ConnectionState.waiting) {
            return const StartScreen();
          }

          if(snapshot.hasData) {
            //Direcionar para home se o user tiver feito o login
            return const HomeScreen();
          } else {
            //Direcionar para home O login se nao tiver feito o login
            return const LoginScreen();
          }
      }),

     
    );
  }
}
