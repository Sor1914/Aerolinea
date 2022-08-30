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
  bool prueba = false;
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
            Visibility(
              visible: prueba,
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.airplanemode_active),
                  title: Text('Opción 1'),
                  onTap: () {},
                ),
              ),
            ),
            Visibility(
              visible: prueba,
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.airplanemode_active),
                  title: Text('Opción 2'),
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
            padding: EdgeInsets.all(16),
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
                leading: Icon(Icons.airplanemode_active),
                title: Text('Vuelos'),
                onTap: () {
                  setState(() {
                    if (prueba) {
                      prueba = false;
                    } else {
                      prueba = true;
                    }
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
}
