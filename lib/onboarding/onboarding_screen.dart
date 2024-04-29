import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
      body: SizedBox(
        child: Container(
          margin: const EdgeInsets.all(40),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //const SizedBox(height: 24),
              const Text(
                'Encontre a Sua Nova Casa',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
              // SizedBox(height: 24),
              const Text(
                'Olá e seja bem-vindo a KAYA! Estamos animados em tê-lo(a) a bordo para ajudá-lo(a) a encontrar a casa dos seus sonhos. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              //const SizedBox(height: 80),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)
                  )
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Text(
                        'Seguinte',
                        style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward, 
                      color: Colors.black
                    ),
                  ]
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}