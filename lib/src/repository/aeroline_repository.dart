import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aerolinea/src/models/reponse.dart';
import 'package:aerolinea/src/models/aerolinea.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('aerolinea');

class AerolineaRepository {
  //agregar Aerolinea
  late FirebaseAuth _firebaseAuth;
  Future<Response> addAerolinea({required Aerolinea aerolinea}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nombre": aerolinea.nombre,
      "codigo": aerolinea.codigo,
      "telefono": aerolinea.telefono,
      "correo": aerolinea.correo,
      "estado": aerolinea.estado,
      "fechaCrea": aerolinea.fechaCre,
      "usuarioCrea": aerolinea.usuarioCrea,
      "fechaMod": aerolinea.fechaModifica,
      "usuarioMod": aerolinea.usuarioModifica,
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

  Stream<QuerySnapshot> readAerolineas() {
    return _Collection.snapshots();
  }

  Future<Response> updAerolinea({required Aerolinea aerolinea}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc("codigo");
    Map<String, dynamic> data = <String, dynamic>{
      "nombre": aerolinea.nombre,
      "codigo": aerolinea.codigo,
      "telefono": aerolinea.telefono,
      "correo": aerolinea.correo,
      "estado": aerolinea.estado,
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
