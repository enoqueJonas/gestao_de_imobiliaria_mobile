import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/database/Models/usuario.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  final _db = FirebaseFirestore.instance;

  createUser(Usuario usuario) async {
    await _db.collection('Usuarios').add(usuario.toJson());
  }
  
}