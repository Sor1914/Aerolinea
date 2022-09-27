import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgregarAvion extends StatefulWidget {
  @override
  _AgregarAvion createState() => _AgregarAvion();
}

class _AgregarAvion extends State<AgregarAvion> {
  String? serie;
  String? marca;
  String? modelo;
  String? aerolinea;
  String? cantidadAsientos;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AgregarAvion'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    TextField(
                      maxLength: 9,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        serie = value;
                      },
                      decoration:
                          const InputDecoration(labelText: 'Numero de Serie'),
                    ),
                    TextField(
                      maxLength: 9,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        marca = value;
                      },
                      decoration: const InputDecoration(labelText: 'Marca'),
                    ),
                    TextField(
                      maxLength: 9,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        modelo = value;
                      },
                      decoration: const InputDecoration(labelText: 'Modelo'),
                    ),
                    TextField(
                      maxLength: 9,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        aerolinea = value;
                      },
                      decoration: const InputDecoration(labelText: 'Aerolinea'),
                    ),
                    TextField(
                      maxLength: 9,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        cantidadAsientos = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Cantidad de Asientos'),
                    ),
                  ])),
        ));
  }
}
