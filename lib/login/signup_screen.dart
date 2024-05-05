import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/Models/usuario.dart';
import 'package:gestao_de_imobiliaria_mobile/SQLite/sqlite.dart';
import 'package:gestao_de_imobiliaria_mobile/login/login_screen.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nomeController = TextEditingController();
  final apelidoController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final contactoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Criar uma Conta",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 48),
            ),
            const SizedBox(height: 10),
            Text(
              "Preencha os campos abaixo para ter acesso completo à aplicação",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            //
            //campo do nome
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o Nome";
                  }
                  return null;
                },
                controller: nomeController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nome',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(20))),
            const SizedBox(height: 10),
            //
            //campo do apelido
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o apelidoController";
                  }
                  return null;
                },
                controller: apelidoController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Apelido',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(20))),
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
              controller: dataNascimentoController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Data de Nascimento',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.all(20),
                  suffixIcon: Icon(Icons.calendar_today)),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                var _selectedDate;
                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = pickedDate;
                    dataNascimentoController.text =
                        DateFormat('dd/MM/yyyy').format(_selectedDate);
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
                controller: contactoController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Contacto',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(20))),
            const SizedBox(height: 10),
            //
            //campo do email
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira Email válido";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(20))),
            const SizedBox(height: 10),
            //
            //campo do password
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira Password válido";
                  }
                  return null;
                },
                controller: passwordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Palavra-passe',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(20),
                    suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.remove_red_eye_rounded)))),
            const SizedBox(height: 10),
            //
            //campo para confirmar a palavra passe
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Repita a palavra passe inserida acima";
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    return "Palavra passe não correspondente.";
                  }
                  return null;
                },
                controller: confirmPasswordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Confirmar Palavra-passe',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(20),
                    suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.remove_red_eye_rounded)))),
            //   const SizedBox(height: 50),
            //
            CheckboxListTile(
              title: Text(
                'Eu concordo com os Termos de Servico e Políticas de Privacidade',
                style: TextStyle(color: Colors.black),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: agree,
              onChanged: (newValue) {
                setState(() {
                  agree = newValue!;
                });
              },
            ),

            //
            //botao registar
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() && agree) {
                        //cria objecto usuario
                        var usuario = Usuario(
                          nomeController.text,
                          apelidoController.text,
                          dataNascimentoController.text,
                          contactoController.text,
                          emailController.text,
                          passwordController.text,
                        );

                        //metodo registar o susario
                        final db = DatabaseHelper();
                        db.registar(usuario).then((id) {
                          if (id != null && id > 0) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          }
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 40,
                        ),
                        backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    child: const Text('Registar',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)))),

            ///
            //botao para registar
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  //Navegar a pagina de login (login_screen)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Já tem uma conta?',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      TextSpan(
                          text: ' Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
