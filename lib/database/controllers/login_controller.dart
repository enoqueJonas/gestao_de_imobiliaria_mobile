import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/database/repository/user_repository.dart/user_repository.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/home/home_screen.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  
  final userRepo = Get.put(UserRepository());
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  emailAndPasswordSigIn(String email, String password) async {
    await UserRepository.instance.loginWithEmailAndPassword(email, password);
    Get.to(() => const HomeScreen());
  }

}