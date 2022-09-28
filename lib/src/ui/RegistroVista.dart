// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';
import 'package:aerolinea/src/resources/usuarioController.dart';
import 'package:aerolinea/src/models/usuario.dart';
import 'package:aerolinea/src/resources/usuarioController.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:aerolinea/src/Assets/RoundedButton.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:intl/intl.dart';

//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? pasaporte;
  String? nombre;
  String? apellido;
  String? fechaNacimiento;
  String? nacionalidad;
  String? email;
  String? codigoPais;
  String? telefono;
  String? codigoPaisEmer;
  String? telefonoEmergencia;
  String? direccion;
  String? password;
  bool? validado = false;
  bool? visible = true;
  String validar = 'Validar';

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  TextEditingController dateInput = TextEditingController();
  TextEditingController numeroInput = TextEditingController();
  TextEditingController emergenciaInput = TextEditingController();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 35, 191, 211),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(0),
                  child: Text(
                    'Registro',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  enabled: (visible),
                  maxLength: 13,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    pasaporte = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.numbers),
                      hintText: 'Ingrese su Número de Pasaporte')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  enabled: (visible),
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    nombre = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.person),
                      hintText: 'Ingrese su Nombre')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  enabled: (visible),
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    apellido = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.person),
                      hintText: 'Ingrese su Apellido')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  enabled: (visible),
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    nacionalidad = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.flag),
                      hintText: 'Ingrese su Nacionalidad')),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                        enabled: (visible),
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          codigoPais = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            icon: const Icon(Icons.phone), hintText: '502')),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextField(
                        enabled: (visible),
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          telefono = value;
                        },
                        onEditingComplete: () async {},
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Numero de Teléfono')),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                        enabled: (visible),
                        maxLength: 3,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          codigoPaisEmer = value;
                        },
                        onEditingComplete: () async {},
                        decoration: kTextFieldDecoration.copyWith(
                            icon: const Icon(Icons.phone), hintText: '+502')),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextField(
                        enabled: (visible),
                        maxLength: 8,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          telefonoEmergencia = value;
                        },
                        onEditingComplete: () async {},
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Emergencia')),
                  ),
                ],
              ),
              TextField(
                  enabled: (visible),
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    direccion = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.home),
                      hintText: 'Ingrese su Dirección')),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                enabled: (visible),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    icon: const Icon(Icons.email),
                    hintText: 'Ingrese su correo'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  enabled: (visible),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.password),
                      hintText: 'Ingrese su contraseña')),
              const SizedBox(
                height: 8.0,
              ),
              /*Ingreso de fecha de nacimiento*/
              Container(
                  padding: EdgeInsets.all(0),
                  // height: MediaQuery.of(context).size.width / 3,
                  child: Center(
                      child: TextField(
                    controller: dateInput,
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.baby_changing_station),
                        hintText: 'Fecha de Nacimiento'),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        print(formattedDate);
                        setState(() {
                          dateInput.text = formattedDate;
                          fechaNacimiento = formattedDate;
                        });
                      } else {}
                    },
                  ))),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: RoundedButton(
                        colour: Color.fromARGB(255, 58, 108, 37),
                        title: validar,
                        onPressed: () async {
                          bool correo = false;
                          bool contrasenia = false;
                          if (email != null) {
                            correo = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email!);
                          } else {
                            correo = false;
                          }

                          if (password != null) {
                            contrasenia = RegExp(
                                    r"^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{8,16}$")
                                .hasMatch(password!);
                          } else {
                            contrasenia = false;
                          }

                          if (pasaporte == null ||
                              pasaporte == '' ||
                              email == null ||
                              email == '' ||
                              telefono == null ||
                              telefono == '' ||
                              nombre == null ||
                              nombre == '' ||
                              apellido == null ||
                              apellido == '' ||
                              codigoPais == null ||
                              codigoPais == '' ||
                              fechaNacimiento == null ||
                              fechaNacimiento == '') {
                            AlertaUnBoton(
                                context,
                                "Error en información",
                                'Por favor llene los campos requeridos: Pasaporte, Correo, Telefono, Nombre, Apellido, Contraseña, Fecha de Nacimiento',
                                'Aceptar',
                                pAccion: () => Navigator.pop(context));
                          } else if (pasaporte?.length != 13) {
                            AlertaUnBoton(context, 'Error',
                                'El pasaporte debe tener 13 dígitos', 'Aceptar',
                                pAccion: () => Navigator.pop(context));
                          } else if (codigoPais?.length != 3) {
                            AlertaUnBoton(
                                context,
                                'Error',
                                'El código de país debe tener 3 dígitos',
                                'Aceptar',
                                pAccion: () => Navigator.pop(context));
                          } else if (telefono?.length != 8) {
                            AlertaUnBoton(
                                context,
                                'Error',
                                'El teléfono debe contener 8 dígitos',
                                'Aceptar',
                                pAccion: () => Navigator.pop(context));
                          } else if (password == null) {
                            AlertaUnBoton(context, 'Error',
                                'Por favor ingrese una contraseña', 'Aceptar',
                                pAccion: () => Navigator.pop(context));
                          } else if (correo == false) {
                            AlertaUnBoton(context, 'Error',
                                'Por favor ingrese un correo válido', 'Aceptar',
                                pAccion: () => Navigator.pop(context));
                          } else if (contrasenia == false) {
                            AlertaUnBoton(
                                context,
                                'Error Contraseña',
                                'La contraseña debe incluir Mayúsculas, Números y Caráceteres Especiales',
                                'Aceptar',
                                pAccion: () => Navigator.pop(context));
                          } else {
                            notificacion(context, 'Notificación',
                                'Los datos son correctos', 0);
                            setState(() {
                              if (validado == true) {
                                validado = false;
                                visible = true;
                                validar = 'Validar';
                                notificacion(context, 'Notificación',
                                    'Se canceló el proceso de registro', 1);
                              } else {
                                validado = true;
                                visible = false;
                                validar = 'Cancelar';
                              }
                            });
                          }
                        },
                      )),
                  const Expanded(flex: 2, child: Text('')),
                  Expanded(
                      flex: 4,
                      child: RoundedButton(
                          colour: Colors.blueAccent,
                          title: 'Registrarse',
                          onPressed: () async {
                            if (validado == false) {
                              AlertaUnBoton(
                                  context,
                                  'Error',
                                  'Por favor valide primero los datos',
                                  'Aceptar',
                                  pAccion: () => Navigator.pop(context));
                            } else {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                if (newUser != null) {
                                  var respuesta = await Usuarios.addUsuario(
                                      idUsuario: newUser.user.uid.toString(),
                                      pasaporte: pasaporte.toString(),
                                      nombre: nombre.toString(),
                                      apellido: apellido.toString(),
                                      codigoPais: codigoPais.toString(),
                                      telefono: telefono.toString(),
                                      codigoPaisEmer: codigoPaisEmer.toString(),
                                      telefonoEmer:
                                          telefonoEmergencia.toString(),
                                      correo: email.toString(),
                                      direccion: direccion.toString(),
                                      fechaNacimiento:
                                          fechaNacimiento.toString(),
                                      nacionalidad: nacionalidad.toString(),
                                      rol: '0',
                                      usuarioCrea: 'CreaciónUsuarios',
                                      fechaCrea: DateTime.now().toString(),
                                      usuarioMod: '',
                                      fechaMod: '',
                                      estado: '1');
                                  Navigator.pushNamed(context, 'login_screen');
                                  notificacion(context, 'Registro',
                                      'Se ha registrado correctamente', 0);
                                }
                              } catch (e) {
                                AlertaUnBoton(
                                    context, 'Error', e.toString(), 'Aceptar',
                                    pAccion: () => Navigator.pop(context));
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
