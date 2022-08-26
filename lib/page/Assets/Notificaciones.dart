import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

void notificacion(
    BuildContext context, String titulo, String mensaje, int tipo) {
  if (tipo == 0) {
    Flushbar(
      title: titulo,
      message: mensaje,
      icon: const Icon(
        Icons.error,
        size: 28,
        color: Color.fromARGB(255, 228, 34, 34),
      ),
      leftBarIndicatorColor: Color.fromARGB(255, 228, 34, 34),
      duration: Duration(seconds: 7),
    ).show(context);
  } else if (tipo == 1) {
    Flushbar(
      title: titulo,
      message: mensaje,
      icon: Icon(
        Icons.notification_add,
        size: 28,
        color: Colors.blue.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 5),
    ).show(context);
  }
}

void AlertaUnBoton(
    BuildContext context, String titulo, String mensaje, String boton) {
  Widget okButton = TextButton(
    child: Text(boton),
    onPressed: () {},
  );

  AlertDialog alert = AlertDialog(
    title: Text(titulo),
    content: Text(mensaje),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void AlertaDosBotones(BuildContext context, String titulo, String mensaje,
    String boton1, String boton2, Function fBoton1(), void fBoton2()) {
  Widget cancelButton = TextButton(
    child: Text(boton1),
    onPressed: () {
      fBoton1;
    },
  );
  Widget continueButton = TextButton(
    child: Text(boton2),
    onPressed: () {
      fBoton2;
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(titulo),
    content: Text(mensaje),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
