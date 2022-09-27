import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool blAerolinea = false;
  bool blVuelos = false;
  bool blConsultas = false;
  bool blUsuarios = false;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Título'),
      ),
      body: Center(
        child: ListView(
          children: [
            //Opción Agregar Aerolínea - Aerolínea
            Visibility(
              visible: blAerolinea,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.airlines_rounded),
                  title: const Text('Agregar Aerolínea'),
                  onTap: () {
                    Navigator.pushNamed(context, 'agregar_aerolinea');
                  },
                ),
              ),
            ),
            //Opción Agregar Avión - Aerolínea
            Visibility(
              visible: blAerolinea,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.airplanemode_active),
                  title: const Text('Agregar Avión'),
                  onTap: () {
                    Navigator.pushNamed(context, 'agregar_avion');
                  },
                ),
              ),
            ),
            //Opción Agregar Avión - Aerolínea
            Visibility(
              visible: blVuelos,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.airplanemode_active),
                  title: const Text('Opción 2'),
                  onTap: () {},
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(''),
          ),
          Visibility(
            visible: true,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.airplanemode_active),
                title: const Text('Vuelos'),
                onTap: () {
                  setState(() {
                    mostrarOcultar('Vuelos');
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Consultas'),
                onTap: () {
                  setState(() {
                    mostrarOcultar('Consultas');
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
          //Botón para ingresar a la aerolínea
          Visibility(
            visible: true,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.airline_seat_flat_outlined),
                title: const Text('Aerolínea'),
                onTap: () {
                  setState(() {
                    mostrarOcultar('Aerolinea');
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Usuarios'),
                onTap: () {
                  setState(() {
                    mostrarOcultar('Usuarios');
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          )
        ],
      )),
    );
  }

  void initState() {
    super.initState();
  }

  String pruebas() {
    final user = _auth.currentUser;
    return user.email.toString();
  }

  void mostrarOcultar(String opcion) {
    switch (opcion) {
      case "Aerolinea":
        blVuelos = false;
        blConsultas = false;
        blUsuarios = false;
        if (blAerolinea) {
          blAerolinea = false;
        } else {
          blAerolinea = true;
        }
        break;
      case "Vuelos":
        blAerolinea = false;
        blConsultas = false;
        blUsuarios = false;
        if (blAerolinea) {
          blVuelos = false;
        } else {
          blVuelos = true;
        }
        break;
      case "Consultas":
        blAerolinea = false;
        blVuelos = false;
        blUsuarios = false;
        if (blAerolinea) {
          blConsultas = false;
        } else {
          blConsultas = true;
        }
        break;
      case "Usuarios":
        blAerolinea = false;
        blVuelos = false;
        blConsultas = false;
        if (blAerolinea) {
          blUsuarios = false;
        } else {
          blUsuarios = true;
        }
        break;
    }
  }
}
