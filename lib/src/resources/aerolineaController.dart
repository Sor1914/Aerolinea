import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aerolinea/src/models/reponse.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('aerolinea');

class Aerolinea {
  //agregar Aerolinea
  static Future<Response> addAerolinea(
      {required String nombre,
      required String codigo,
      required String telefono,
      required String correo}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nombre": nombre,
      "codigo": codigo,
      "telefono": telefono,
      "correo": correo,
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
}
