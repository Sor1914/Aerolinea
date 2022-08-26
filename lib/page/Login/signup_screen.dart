import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:aerolinea/page/Assets/RoundedButton.dart';
import 'package:aerolinea/page/Assets/Notificaciones.dart';
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
  String? telefono;
  String? numeroEmergencia;
  String? direccion;
  String? password;

  TextEditingController dateInput = TextEditingController();
  TextEditingController numeroInput = TextEditingController();
  TextEditingController emergenciaInput = TextEditingController();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    late String telefonoSub;
    late String telefonoSube;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
              TextField(
                  controller: numeroInput,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    telefonoSub = value;
                  },
                  onEditingComplete: () async {
                    ValidaTelefono(telefonoSub);
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.phone),
                      hintText: 'Código de país y número telefónico')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  controller: emergenciaInput,
                  onChanged: (value) {
                    telefonoSube = value;
                  },
                  onEditingComplete: () async {
                    ValidaTelefonoEmergencia(telefonoSube);
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.phone),
                      hintText: 'Código de país y número de emergencias')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
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
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.email),
                      hintText: 'Ingrese su correo')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
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
              RoundedButton(
                colour: Colors.blueAccent,
                title: 'Validar',
                onPressed: () async {
                  if (telefonoSub == null) {
                  } else {
                    ValidaTelefono(telefonoSub);
                  }

                  /*Validamos número de teléfono de emergencia*/
                  ValidaTelefonoEmergencia(telefonoSube);
                  void funcion() {}
                  AlertaUnBoton(
                      context, 'Prueba', 'Mensaje de prueba', 'Aceptar');
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, 'home_screen');
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void ValidaTelefono(String telefonoSub) {
    String codigoPais;
    String numero;
    String numeroFinal;

    telefonoSub = telefonoSub.replaceAll('+', '').replaceAll(' ', '');
    codigoPais = '+${telefonoSub.substring(0, 3)}';
    numero = telefonoSub.substring(4, telefonoSub.length);

    numeroFinal = '$codigoPais $numero';

    print(numeroFinal);
    setState(() {
      numeroInput.text = numeroFinal;
    });
  }

  /*Validamos número de teléfono de emergencia*/
  void ValidaTelefonoEmergencia(String telefonoSube) {
    String codigoPais;
    String numero;
    String numeroFinal;

    telefonoSube = telefonoSube.replaceAll('+', '').replaceAll(' ', '');
    codigoPais = '+${telefonoSube.substring(0, 3)}';
    numero = telefonoSube.substring(4, telefonoSube.length);

    numeroFinal = '$codigoPais $numero';

    print(numeroFinal);
    setState(() {
      emergenciaInput.text = numeroFinal;
    });
  }
}
