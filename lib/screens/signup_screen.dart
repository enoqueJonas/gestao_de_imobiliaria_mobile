import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/database/Models/usuario.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';


final _firebase = FirebaseAuth.instance;
final _firebaseFirestore = FirebaseFirestore.instance;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _nome = '';
  var _apelido = '';
  var _dataNascimento = '';
  var _contacto = '';
  var _email = '';
  var _password = '';
  var _confirmPassword = '';

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisivel = false;
  bool _passwordConfirmVisivel = false;
  bool agree = false;

  void _submit() async{
    final isValid = _formKey.currentState!.validate();

    if(isValid) {
      _formKey.currentState!.save();
      try {
        //Guardar o email e o password no Firebase auth
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _email, 
          password: _password
        );

        final user = Usuario(
          id: userCredentials.user!.uid,
          nome: _nome,
          apelido: _apelido,
          dataNascimento: _dataNascimento,
          contacto: _contacto,
          email: _email,
        );
        
        //Guardar os restantes dados Firebase firestore
        _firebaseFirestore.collection('Usuarios').add(user.toJson());

          Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );

      }
      on FirebaseAuthException catch (error) {
        if(error.code == 'email-already-in-use') {

        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(error.message ?? "Autenticação falhou.")
          )
        );
      }
    }
  }
  
  @override
  void initState() {
    _passwordVisivel = false;
    _passwordConfirmVisivel = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20
        ),  
        child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Criar uma Conta",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 36
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Preencha os campos abaixo para ter acesso completo à aplicação",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18
              ),
            ),
            const SizedBox(height: 20),
            //
            //campo do nome
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Insira o Nome";
                }
                return null;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nome',
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
                contentPadding: const EdgeInsets.all(20), 
              ),
              onSaved: (value) {
                  _nome = value!;
                }
          ),
            const SizedBox(height: 10),
            //
            //campo do apelido
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Insira o apelido";
                }
                return null;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Apelido',
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
                contentPadding: EdgeInsets.all(20)
              ),
              onSaved: (value) {
                  _apelido = value!;
                }
              
            ),
            const SizedBox(height: 10),
            //
            //campo da data de nascimento
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Por favor, insira uma data válida";
                }
                return null;
              },
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Data de Nascimento',
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
                contentPadding: const EdgeInsets.all(20),
                suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey)
              ),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );
                var _selectedDate;
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                    _dataNascimento = DateFormat('dd/MM/yyyy').format(_selectedDate);
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            //
            //campo do Contacto
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Insira contacto valido";
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Contacto',
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
                suffixIcon: const Icon(Icons.phone_android_sharp, color: Colors.grey,),
                contentPadding: const EdgeInsets.all(20)
                ),
                onSaved: (value) {
                  _contacto = value!;
                }
            ),         
            const SizedBox(height: 10),
            //
            //campo do email
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty || !value.contains('@')) {
                  return "Insira Email válido";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
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
                suffixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                contentPadding: const EdgeInsets.all(20)
                ),
                onSaved: (value) {
                  _email = value!;
                }
              ),
            
            const SizedBox(height: 10),
            //
            //campo do password
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().length < 8 ) {
                  return "Insira Password válido";
                }
                return null;
              },
              obscureText: !_passwordVisivel,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
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
                contentPadding: const EdgeInsets.all(20),
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
                )
              ),
              onSaved: (value) {
                _password = value!;
              } 
            ),
            const SizedBox(height: 10),
            //
            //campo para confirmar a palavra passe
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Repita a palavra passe inserida acima";
                } else if (_password !=
                    _confirmPassword) {
                  return "Palavra passe não correspondente.";
                }
                return null;
              },
              
              obscureText: !_passwordConfirmVisivel,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Confirmar Palavra-passe',
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
                contentPadding: const EdgeInsets.all(20),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordConfirmVisivel = !_passwordConfirmVisivel;
                    });
                  },
                  icon: Icon(
                    _passwordConfirmVisivel ? Icons.visibility : Icons.visibility_off,
                    color: _passwordConfirmVisivel ? Colors.black : Colors.grey
                  )
                )
              ),
              onSaved: (value) {
                _confirmPassword = value!;
              }
            
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text(
                'Eu concordo com os Termos de Servico e Políticas de Privacidade',
                style: TextStyle(color: Colors.black),
              ),
              activeColor: Color.fromRGBO(26, 147, 192, 1),
              controlAffinity: ListTileControlAffinity.leading,
              value: agree,
              onChanged: (newValue) {
                setState(() {
                  agree = newValue!;
                });
              },
            ),

            //
            //botao 
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                //Subtmeter
                onPressed: _submit,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)
                  )
              ),
              child: const Text('Registar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)
                  )
                )
              ),

            ///
            //botao para registar
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  //Navegar a pagina de login (login_screen)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Já tem uma conta?',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                      TextSpan(
                        text: ' Login',
                        style: TextStyle(
                          color: const Color.fromRGBO(26, 147, 192, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
      )
    );
  }
}
