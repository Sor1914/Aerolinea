import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aerolinea/src/models/reponse.dart';
import 'package:aerolinea/src/models/avion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/aerolinea.dart';
import '../models/seat.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('avion');
final CollectionReference _Collection2 = _firestore.collection('tickets');

class AvionRepository {
  //agregar Aerolinea
  Future<Response> addAvion({required Avion avion}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "serie": avion.serie,
      "marca": avion.marca,
      "modelo": avion.modelo,
      "aerolinea": avion.aerolinea,
      "asientos": avion.asientos,
      "estado": avion.estado,
      "fechaCrea": avion.fechaCre,
      "listaAsientosTemp": avion.listaAsientosTemp,
      "listaAsientos": avion.listaAsientos,
      "usuarioCrea": avion.usuarioCrea,
      "fechaMod": avion.fechaModifica,
      "usuarioMod": avion.usuarioModifica,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Se agregó correctamente a la base de datos";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  Stream<QuerySnapshot> readAvion() {
    return _Collection.snapshots();
  }

  Future<Response> updSeatTemporal(
      {required Avion avion, required String idDocumento}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(idDocumento);
    Map<String, dynamic> data = <String, dynamic>{
      "listaAsientosTemp": avion.listaAsientosTemp,
      //"listaAsientos": avion.listaAsientos,
    };

    var result = await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Se agregó correctamente a la base de datos";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

//Tambien Tickets, van de la mano
  Future<Response> updSeat({required String idDocumento}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(idDocumento);
    final snapshot = await FirebaseFirestore.instance
        .collection("avion")
        .doc(idDocumento)
        .get();
    var listaAsientos = snapshot.data()['listaAsientos'];

    final snapshotTemp = await FirebaseFirestore.instance
        .collection("avion")
        .doc(idDocumento)
        .get();
    var listaAsientosTemp = snapshot.data()['listaAsientosTemp'];
    Map<String, dynamic> data = <String, dynamic>{
      "listaAsientos": listaAsientos + listaAsientosTemp
    };

    var result = await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Se agregó correctamente a la base de datos";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    addTicket(listaAsientos: listaAsientosTemp);
    return response;
  }

  Future<Response> addTicket({var listaAsientos}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection2.doc();
    var tickets = listaAsientos.split('|');
    for (var element in tickets) {
      if (element != "") {
        Map<String, dynamic> data = <String, dynamic>{
          "ticket": "JESM-" + element,
          "nombre": "Jonathan Sor",
          "usuario": "jonathansor2000sm@gmail.com",
          "fechaSalida": "30/10/2022",
          "fechaLlegada": "31/10/2022",
          "aeropuertoSalida": "AirPrueba",
          "aeropuertoLlegada": "AirPruebaLlegada",
          "origen": "Guatemala",
          "destino": "México",
          "asiento": element,
          "usuarioCreo": "jonathansor2000sm@gmail.com",
          "fechaCreo": DateTime.now(),
          "usuarioModifica": "",
          "fechaModifica": "",
        };

        await documentReferencer.set(data).whenComplete(() {
          response.code = 200;
          response.message = "Se agregó correctamente a la base de datos";
        }).catchError((e) {
          response.code = 500;
          response.message = e;
        });
      }
    }

    return response;
  }

  Future<void> getSeat({required Seato seat}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("avion")
        .doc(seat.idDocumento)
        .get();

    seat.seleccionados = snapshot.data()['listaAsientos'];
  }
}
