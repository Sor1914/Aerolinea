import 'dart:async';
import 'package:aerolinea/src/repository/usuarioController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aerolinea/src/models/usuario.dart';

class UserRepository {
  late FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<String> addUsuario(
      Usuario usuario,
      String usuarioCrea,
      String fechaCrea,
      String usuarioMod,
      String fechaMod,
      String estado) async {
    String respuesta = "";
    final CollectionReference _Collection = _firestore.collection('usuario');
    DocumentReference documentReferencer = _Collection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "idUsuario": usuario.idUsuario,
      "pasaporte": usuario.pasaporte,
      "nombre": usuario.nombre,
      "apellido": usuario.apellido,
      "codigoPais": usuario.codigoPais,
      "telefono": usuario.telefono,
      "codigoPaisEmer": usuario.codigoPaisEmer,
      "telefonoEmer": usuario.telefonoEmer,
      "correo": usuario.correo,
      "direccion": usuario.direccion,
      "fechaNacimiento": usuario.fechaNacimiento,
      "nacionalidad": usuario.nacionalidad,
      "usuarioCrea": usuarioCrea,
      "fechaCrea": fechaCrea,
      "usuarioMod": usuarioMod,
      "fechaMod": fechaMod,
      "estado": estado,
    };

    await documentReferencer.set(data).whenComplete(() {
      respuesta = "Se agregó correctamente a la base de datos";
    }).catchError((e) {
      respuesta = e.toString();
    });

    return respuesta;
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
    return (_firebaseAuth.currentUser).email;
  }
}
