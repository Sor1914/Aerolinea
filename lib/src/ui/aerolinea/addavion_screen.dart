import 'package:aerolinea/src/blocs/avion_bloc/bloc.dart';
import 'package:aerolinea/src/models/avion.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:aerolinea/src/repository/avion_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../AgregarAvion.dart';

class AddAvionScreen extends StatelessWidget {
  @override
  final AvionRepository _repository;
  final UserRepository _userRepository;

  AddAvionScreen(
      {Key? key,
      required AvionRepository repository,
      required UserRepository userRepository})
      : assert(repository != null),
        _repository = repository,
        _userRepository = userRepository,
        super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<AvionBloc>(
            create: (context) => AvionBloc(repository: _repository),
            child: AddAvionForm(
              repository: _repository,
              userRepository: _userRepository,
            )));
  }
}

class AddAvionForm extends StatefulWidget {
  final AvionRepository? _repository;
  final UserRepository _userRepository;
  AddAvionForm(
      {Key? key,
      required AvionRepository repository,
      required UserRepository userRepository})
      : assert(repository != null),
        _repository = repository,
        _userRepository = UserRepository(),
        super(key: key);

  @override
  _AddAvionFormState createState() => _AddAvionFormState();
}

final _auth = FirebaseAuth.instance;

class _AddAvionFormState extends State<AddAvionForm> {
  String usuario = "No encontrado";
  int _selectedIndex = 0;
  final txtSerie = TextEditingController();
  final txtMarca = TextEditingController();
  final txtModelo = TextEditingController();
  final txtAerolinea = TextEditingController();
  final txtAsientos = TextEditingController();
  String? dropdownValue = 'Dog';
  final _formKey = GlobalKey<FormState>();
  late AvionBloc _AvionBloc;

  List<String> aerolineasList = ['0', '1'];
  //List<String> prueba = _repository.getAerolineas();
  AvionRepository? get _repository => widget._repository;

  @override
  void initState() {
    super.initState();
    _AvionBloc = BlocProvider.of<AvionBloc>(context);
    getUserrrr();
  }

  @override
  Widget build(BuildContext context) {
    String usuario;
    AvionRepository _repository = AvionRepository();
    UserRepository _userRepository = UserRepository();

    return BlocListener<AvionBloc, AvionState>(listener: (context, state) {
      if (state.isFailure) {
        notificacion(context, 'Error', 'Los datos no se guardaron', 1);
        Scaffold.of(context).hideCurrentSnackBar();
      }
      if (state.isSubmitting) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                Text('Guardando...'),
                CircularProgressIndicator(),
              ])));
      }
      if (state.isSuccess) {
        Navigator.pop(context);
        notificacion(context, 'Correcto', 'Los Datos Se Han Guardado', 0);
        Scaffold.of(context).hideCurrentSnackBar();
      }
    }, child: BlocBuilder<AvionBloc, AvionState>(
      builder: (context, state) {
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
                                    return 'Por favor ingrese la serie';
                                  }
                                },
                                controller: txtSerie,
                                keyboardType: TextInputType.name,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                    labelText: 'Número de Serie'),
                              ),
                              TextFormField(
                                controller: txtMarca,
                                maxLength: 3,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration:
                                    const InputDecoration(labelText: 'Marca'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese la Marca';
                                  }
                                },
                              ),
                              TextFormField(
                                controller: txtModelo,
                                maxLength: 8,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration:
                                    const InputDecoration(labelText: 'Modelo'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese el modelo';
                                  }
                                },
                              ),
                              DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Aerolinea'),
                                  value: '1',
                                  items: aerolineasList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  }),
                              Row(
                                children: const <Widget>[
                                  Expanded(child: Text(''))
                                ],
                              ),
                              Row(
                                children: const <Widget>[
                                  Expanded(child: Text(''))
                                ],
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _onSave();
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
                    ])),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.add), label: "Crear"),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.change_circle), label: "Modificar"),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.red[800],
            onTap: _onItemTapped,
          ),
        );
      },
    ));
  }

  void limpiarCampos() {
    txtAerolinea.clear();
    txtAsientos.clear();
    txtMarca.clear();
    txtModelo.clear();
    txtSerie.clear();
  }

  void getUserrrr() async {
    usuario = await _repository!.getUser();
  }

  void _onSave() {
    DateTime now = DateTime.now();
    Avion avion = Avion(
      aerolinea: dropdownValue,
      asientos: txtAsientos.text,
      estado: "1",
      fechaCre: now.toString(),
      marca: txtMarca.text,
      modelo: txtModelo.text,
      serie: txtSerie.text,
      usuarioCrea: "aunno",
    );

    _AvionBloc.add(AddRegister(avion: avion));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        //pasar a la otra pantalla
      }
    });
  }
}
