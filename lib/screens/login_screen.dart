import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/forget_password_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/home_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/signup_screen.dart';


final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var _email = '';
  var _password = '';
  bool _passwordVisivel = false;
  bool _passwordConfirmVisivel = false;

  final _formKey = GlobalKey<FormState>();

  void _submit() async{
    final isValid = _formKey.currentState?.validate() ?? false;

    if(isValid) {
      _formKey.currentState!.save();
      try {
        //Efectuar login
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _email, 
          password: _password
        );

        Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
      }
      on FirebaseAuthException catch (error) {
        if(error.code == 'email-already-in-use') {

        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? "Autenticação falhou.")
          )
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1605125354450-9bc69f892817?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTg0fHxidWlsZGluZ3xlbnwwfHwwfHx8MA%3D%3D'),
                  fit: BoxFit.fill)),
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
                    'Bem vindo, faça login e começa a procurar.',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  ),
                  const SizedBox(height: 60),
                  Form(
                    key: _formKey,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Insira Email válido";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: const Color.fromRGBO(26, 147, 192, 1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              contentPadding: EdgeInsets.all(20)),
                              onSaved: (value) {
                                _email = value ?? '';
                              }                          
                            ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Insira Password válido";
                          }
                          return null;
                        },
                        obscureText: !_passwordVisivel,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.lock_rounded),
                          hintText: 'Palavra-passe',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: const Color.fromRGBO(26, 147, 192, 1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          contentPadding: EdgeInsets.all(20),
                          suffixIcon: IconButton(
                            onPressed: () {
                            setState(() {
                              _passwordVisivel = !_passwordVisivel;
                            });
                          },
                          icon: Icon(
                            _passwordVisivel ? Icons.visibility : Icons.visibility_off,
                            color: _passwordVisivel ? Colors.black : Colors.grey
                            )
                          ),
                        ),
                        onSaved: (value) {
                          _password = value ?? '';
                        }
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                             Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => const ForgetPasswordScreen(),
                            )
                          );
                          },
                          child: const Text('Esqueceu a sua palavra-passe?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  decorationColor: Colors.white)),
                        ),
                      ),
                      //botao login
                      const SizedBox(height: 30),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              backgroundColor:
                                  const Color.fromRGBO(26, 147, 192, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                            child: const Text('Entrar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)))),
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
                                        color: Colors.white, fontSize: 16)),
                                TextSpan(
                                    text: ' Registar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
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
                          child: const Text('Registar mais tarde',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  decorationColor: Colors.white)),
                        ),
                      ),
                      
                    ],
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
