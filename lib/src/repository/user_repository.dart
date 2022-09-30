import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  late FirebaseAuth _firebaseAuth;

//Constructor
  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

/*Inicio de sesión*/
  Future<void> signWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

//Registro
  Future<UserCredential> register(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //Cerrar sesión
  Future<Future<List<void>>> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  //Verificar Logueo
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser).email;
  }
}
