import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:aerolinea/src/repository/aerolineaController.dart';

class AgregarAerolinea extends StatefulWidget {
  @override
  _AgregarAerolinea createState() => _AgregarAerolinea();
}

class _AgregarAerolinea extends State<AgregarAerolinea> {
  String? nombreAerolinea;
  String? correoAerolinea;
  String? telefonoAerolinea;
  String? codigo;

  final txtNombre = TextEditingController();
  final txtCorreo = TextEditingController();
  final txtTelefono = TextEditingController();
  final txtCodigo = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Aerolínea'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingrese información';
                                }
                              },
                              controller: txtNombre,
                              keyboardType: TextInputType.name,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                nombreAerolinea = value;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Nombre de la Aerolínea'),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: txtCodigo,
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      codigo = value;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Código'),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(''),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextField(
                                    controller: txtTelefono,
                                    maxLength: 8,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      telefonoAerolinea = value;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Teléfono'),
                                  ),
                                )
                              ],
                            ),
                            TextFormField(
                              controller: txtCorreo,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                correoAerolinea = value;
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Correo'),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          onPrimary: Colors.white),
                                      child: const Text('Guardar'),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Processing Data')),
                                          );
                                        }
                                        bool correo = false;
                                        if (correoAerolinea != null &&
                                            nombreAerolinea != null &&
                                            telefonoAerolinea != null &&
                                            telefonoAerolinea != '' &&
                                            nombreAerolinea != '' &&
                                            telefonoAerolinea != '') {
                                          correo = RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(correoAerolinea!);
                                          if (correo == false) {
                                            AlertaUnBoton(
                                                context,
                                                'Error',
                                                'Por favor ingrese un correo válido',
                                                'Aceptar',
                                                pAccion: () =>
                                                    Navigator.pop(context));
                                          } else if (telefonoAerolinea
                                                      ?.length !=
                                                  8 ||
                                              codigo?.length != 3) {
                                            AlertaUnBoton(
                                                context,
                                                'Error',
                                                'Por favor ingrese un número telefonico válido',
                                                'Aceptar',
                                                pAccion: () =>
                                                    Navigator.pop(context));
                                          } else {
                                            //Todas las validaciones fueron correctas y se guarda la información
                                            try {
                                              var respuesta =
                                                  Aerolinea.addAerolinea(
                                                      nombre: nombreAerolinea
                                                          .toString(),
                                                      codigo: codigo.toString(),
                                                      telefono:
                                                          telefonoAerolinea
                                                              .toString(),
                                                      correo: correoAerolinea
                                                          .toString());
                                              notificacion(
                                                  context,
                                                  'Registro',
                                                  'Se ha registrado correctamente',
                                                  0);
                                              limpiarCampos();
                                            } catch (e) {
                                              AlertaUnBoton(context, 'Error',
                                                  e.toString(), 'Aceptar',
                                                  pAccion: () =>
                                                      Navigator.pop(context));
                                            }
                                          }
                                        } else {
                                          AlertaUnBoton(
                                              context,
                                              'Error',
                                              'Por favor llene todos los campos',
                                              'Aceptar',
                                              pAccion: () =>
                                                  Navigator.pop(context));
                                        }
                                      },
                                    )),
                                const Expanded(
                                  flex: 1,
                                  child: Text(''),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey,
                                          onPrimary: Colors.white),
                                      child: const Text('Limpiar'),
                                      onPressed: () {
                                        limpiarCampos();
                                      },
                                    )),
                              ],
                            ),
                          ],
                        )),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  onPrimary: Colors.white),
                              child: const Text('Guardar'),
                              onPressed: () {
                                bool correo = false;
                                if (correoAerolinea != null &&
                                    nombreAerolinea != null &&
                                    telefonoAerolinea != null &&
                                    telefonoAerolinea != '' &&
                                    nombreAerolinea != '' &&
                                    telefonoAerolinea != '') {
                                  correo = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(correoAerolinea!);
                                  if (correo == false) {
                                    AlertaUnBoton(
                                        context,
                                        'Error',
                                        'Por favor ingrese un correo válido',
                                        'Aceptar',
                                        pAccion: () => Navigator.pop(context));
                                  } else if (telefonoAerolinea?.length != 8 ||
                                      codigo?.length != 3) {
                                    AlertaUnBoton(
                                        context,
                                        'Error',
                                        'Por favor ingrese un número telefonico válido',
                                        'Aceptar',
                                        pAccion: () => Navigator.pop(context));
                                  } else {
                                    //Todas las validaciones fueron correctas y se guarda la información
                                    try {
                                      var respuesta = Aerolinea.addAerolinea(
                                          nombre: nombreAerolinea.toString(),
                                          codigo: codigo.toString(),
                                          telefono:
                                              telefonoAerolinea.toString(),
                                          correo: correoAerolinea.toString());
                                      notificacion(context, 'Registro',
                                          'Se ha registrado correctamente', 0);
                                      limpiarCampos();
                                    } catch (e) {
                                      AlertaUnBoton(context, 'Error',
                                          e.toString(), 'Aceptar',
                                          pAccion: () =>
                                              Navigator.pop(context));
                                    }
                                  }
                                } else {
                                  AlertaUnBoton(
                                      context,
                                      'Error',
                                      'Por favor llene todos los campos',
                                      'Aceptar',
                                      pAccion: () => Navigator.pop(context));
                                }
                              },
                            )),
                        const Expanded(
                          flex: 1,
                          child: Text(''),
                        ),
                        Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  onPrimary: Colors.white),
                              child: const Text('Limpiar'),
                              onPressed: () {
                                limpiarCampos();
                              },
                            )),
                      ],
                    )
                  ])),
        ));
  }

  void limpiarCampos() {
    txtNombre.clear();
    txtCorreo.clear();
    txtTelefono.clear();
    txtCodigo.clear();
  }
}
