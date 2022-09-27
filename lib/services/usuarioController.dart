import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aerolinea/models/reponse.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('usuario');

class Usuarios {
  //agregar empleado
  static Future<Response> addUsuario(
      {required String idUsuario,
      required String pasaporte,
      required String nombre,
      required String apellido,
      required String codigoPais,
      required String telefono,
      required String codigoPaisEmer,
      required String telefonoEmer,
      required String correo,
      required String direccion,
      required String fechaNacimiento,
      required String nacionalidad,
      required String rol,
      required String usuarioCrea,
      required String fechaCrea,
      required String usuarioMod,
      required String fechaMod,
      required String estado}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "idUsuario": idUsuario,
      "pasaporte": pasaporte,
      "nombre": nombre,
      "apellido": apellido,
      "codigoPais": codigoPais,
      "telefono": telefono,
      "codigoPaisEmer": codigoPaisEmer,
      "telefonoEmer": telefonoEmer,
      "correo": correo,
      "direccion": direccion,
      "fechaNacimiento": fechaNacimiento,
      "nacionalidad": nacionalidad,
      "usuarioCrea": usuarioCrea,
      "fechaCrea": fechaCrea,
      "usuarioMod": usuarioMod,
      "fechaMod": fechaMod,
      "estado": estado,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Se agregó Correctamente a la Base de Datos";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  //leer empleado
  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  //Actualizar Empleado
  static Future<Response> updateEmployee({
    required String name,
    required String position,
    required String contactno,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no": contactno
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Se actualizó correctamente";
    }).catchError((e) {
      response.code = 500;
      response.code = e;
    });

    return response;
  }

  //Eliminar registro
  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Se eliminó correctamente";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
