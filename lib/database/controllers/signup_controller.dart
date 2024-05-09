import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/database/Models/usuario.dart';
import 'package:gestao_de_imobiliaria_mobile/database/repository/user_repository.dart/user_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetXState {
  static SignUpController get instance => Get.find();

  final nomeController = TextEditingController();
  final apelidoController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final contactoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final userRepo = Get.put(UserRepository());
  
  void signup(Usuario usuario) async {
    //Registar usuario no firebase authentication e guardar os dados
    final userCredential = await UserRepository.instance.registerWithEmailAndPassword(usuario.email, usuario.password);

    //Guardar os dados do usuario no firebase firestore
    final newUser = Usuario(
      id: userCredential.user!.uid,
      nome: usuario.nome,
      apelido: usuario.apelido,
      dataNascimento: usuario.dataNascimento,
      contacto: usuario.contacto,
      email: usuario.email,
      password: ''
    );
   
    await userRepo.createUser(newUser);
  } 
}