import 'package:flutter/material.dart';

import 'package:gestao_de_imobiliaria_mobile/screens/home/home_screen.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1605125354450-9bc69f892817?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTg0fHxidWlsZGluZ3xlbnwwfHwwfHx8MA%3D%3D'),
            fit: BoxFit.fill)
          ),

          child: SizedBox.expand(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  const Text(
                    'Faça login e começa a procurar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36
                    ),
                  ),

                  const SizedBox(height: 60),
                  Form(
                    key: _formKey,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty || !value.contains('@')) {
                            return "Insira Email válido";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        contentPadding: const EdgeInsets.all(20),                       
                        )
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().length < 8 ) {
                            return "Insira Password válido";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.lock_rounded),
                          hintText: 'Palavra-passe',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          suffixIcon: const IconButton(
                              onPressed: null,
                              icon: Icon(Icons.remove_red_eye_rounded)
                            )
                          )
                        ),
                      const SizedBox(height: 15),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forgetpassword');
                          },
                          child: const Text(
                            'Esqueceu a sua palavra-passe?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                              decorationColor: Colors.white
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            if (_formKey.currentState!.validate()){

   
                             
                             Navigator.pushNamed(context, '/home'); 

                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal: 40,
                            ),
                            backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                            )
                          ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                            )
                          )
                        )
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            //Navegar a pagina de registo (sign up)
                            Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                          },
                          child: const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Ainda não tem uma conta?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)
                                    ),
                                TextSpan(
                                  text: ' Registar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Registar mais tarde',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                              decorationColor: Colors.white
                            )
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ),
    );
  }
}
