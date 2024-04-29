import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              Color.fromRGBO(8, 146, 192, 0.87),
              Color.fromRGBO(26, 147, 192, 1),
            ]
          )
        ),
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
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      );
  }
}