import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aerolinea/src/models/reponse.dart';
import 'package:aerolinea/src/models/avion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/aerolinea.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('avion');

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

  Future<Response> updAvion({required Avion avion}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc("codigo");
    Map<String, dynamic> data = <String, dynamic>{
      "serie": avion.serie,
      "marca": avion.marca,
      "modelo": avion.modelo,
      "aerolinea": avion.aerolinea,
      "asientos": avion.asientos,
      "estado": avion.estado,
      "fechaCrea": avion.fechaCre,
      "usuarioCrea": avion.usuarioCrea,
      "fechaMod": avion.fechaModifica,
      "usuarioMod": avion.usuarioModifica,
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
}
