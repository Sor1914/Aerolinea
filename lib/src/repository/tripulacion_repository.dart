import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aerolinea/src/models/reponse.dart';
import 'package:aerolinea/src/models/tripulacion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/aerolinea.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Tripulacion');

class TripulacionRepository {
  //agregar Aerolinea
  late FirebaseAuth _firebaseAuth;
  Future<Response> addTripulacion({required Tripulacion tripulacion}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    String? nombre;
    String? piloto;
    String? copiloto;
    String? ingenieroDeVuelo;
    String? tripulanteDeCabina;
    String? aerolinea;
    String? estado;
    String? fechaCre;
    String? usuarioCrea;
    String? fechaModifica;
    String? usuarioModifica;
    Map<String, dynamic> data = <String, dynamic>{
      "nombre": tripulacion.nombre,
      "piloto": tripulacion.piloto,
      "copiloto": tripulacion.copiloto,
      "ingenieroDeVuelo": tripulacion.ingenieroDeVuelo,
      "tripulanteDeCabina": tripulacion.tripulanteDeCabina,
      "estado": tripulacion.estado,
      "fechaCrea": tripulacion.fechaCre,
      "usuarioCrea": tripulacion.usuarioCrea,
      "fechaMod": tripulacion.fechaModifica,
      "usuarioMod": tripulacion.usuarioModifica,
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

  Stream<QuerySnapshot> readTripulacion() {
    return _Collection.snapshots();
  }

  Future<List<Aerolinea>> getAerolinea() async {
    CollectionReference _Collections = await _firestore.collection('aerolinea');
    DocumentReference documentReferencer = _Collections.doc();

    List<Aerolinea> aerolinea = [];
    try {
      Stream<QuerySnapshot> snap = _Collection.snapshots();
      var data = Map<String, dynamic>.from(snap as Map);

      return aerolinea;
    } catch (e) {
      return aerolinea;
    }
  }

  Future<Response> updTripulacion({required Tripulacion Tripulacion}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc("codigo");
    Map<String, dynamic> data = <String, dynamic>{
      // "serie": Tripulacion.serie,
      // "marca": Tripulacion.marca,
      // "modelo": Tripulacion.modelo,
      // "aerolinea": Tripulacion.aerolinea,
      // "asientos": Tripulacion.asientos,
      // "estado": Tripulacion.estado,
      // "fechaCrea": Tripulacion.fechaCre,
      "usuarioCrea": Tripulacion.usuarioCrea,
      "fechaMod": Tripulacion.fechaModifica,
      "usuarioMod": Tripulacion.usuarioModifica,
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

  Future<String> getUser() async {
    return (_firebaseAuth.currentUser).email;
  }
}
