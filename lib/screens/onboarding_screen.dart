import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1613061538705-01190bb0e3b8?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              fit: BoxFit.fill)),
      child: SizedBox(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Encontre a Sua Nova Casa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Olá e seja bem-vindo a KAYA! Estamos animados em tê-lo(a) a bordo para ajudá-lo(a) a encontrar a casa dos seus sonhos. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      'Seguinte',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.black),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
