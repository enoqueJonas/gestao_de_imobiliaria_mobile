import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/signup_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            Image.asset(
              'images/forgot-password.png',
            ),
            const Text(
              'Redefina a sua palavra-passe',
              textAlign: TextAlign.center,
              style: TextStyle(color: const Color.fromRGBO(26, 147, 192, 1), fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const Text(
              'Insira seu endereço de e-mail e um link será enviado para redefinir sua palavra-passe.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Form(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                  decoration: InputDecoration(
                      //filled: true,
                      //fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.mail),
                      hintText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.all(20))),
              const SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        //Navegar a pagina de registo (sign up)
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 40,
                          ),
                          backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                      child: const Text('Enviar',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)))),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Ainda não tem uma conta?', style: TextStyle(color: Colors.black, fontSize: 16)),
                        TextSpan(
                            text: ' Registar',
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ),
            ])),
          ],
        ),
      ),
    );
  }
}
