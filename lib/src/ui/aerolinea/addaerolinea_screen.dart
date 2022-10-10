import 'package:aerolinea/src/blocs/aerolinea_bloc/bloc.dart';
import 'package:aerolinea/src/models/aerolinea.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:aerolinea/src/repository/aeroline_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../AgregarAvion.dart';

class AddAerolineaScreen extends StatelessWidget {
  @override
  final AerolineaRepository _repository;
  final UserRepository _userRepository;

  AddAerolineaScreen(
      {Key? key,
      required AerolineaRepository repository,
      required UserRepository userRepository})
      : assert(repository != null),
        _repository = repository,
        _userRepository = userRepository,
        super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<AerolineaBloc>(
            create: (context) => AerolineaBloc(repository: _repository),
            child: AddAerolineaForm(
              repository: _repository,
              userRepository: _userRepository,
            )));
  }
}

class AddAerolineaForm extends StatefulWidget {
  final AerolineaRepository? _repository;
  final UserRepository _userRepository;
  AddAerolineaForm(
      {Key? key,
      required AerolineaRepository repository,
      required UserRepository userRepository})
      : assert(repository != null),
        _repository = repository,
        _userRepository = UserRepository(),
        super(key: key);

  @override
  _AddAerolineaFormState createState() => _AddAerolineaFormState();
}

final _auth = FirebaseAuth.instance;

class _AddAerolineaFormState extends State<AddAerolineaForm> {
  String usuario = "No encontrado";
  int _selectedIndex = 0;
  final txtNombre = TextEditingController();
  final txtCorreo = TextEditingController();
  final txtTelefono = TextEditingController();
  final txtCodigo = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late AerolineaBloc _aerolineaBloc;
  AerolineaRepository? get _repository => widget._repository;

  @override
  void initState() {
    super.initState();
    _aerolineaBloc = BlocProvider.of<AerolineaBloc>(context);
    txtCorreo.addListener(_onEmailChanged);
    getUserrrr();
  }

  @override
  Widget build(BuildContext context) {
    String usuario;
    AerolineaRepository _repository = AerolineaRepository();
    UserRepository _userRepository = UserRepository();

    return BlocListener<AerolineaBloc, AerolineaState>(
        listener: (context, state) {
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
    }, child: BlocBuilder<AerolineaBloc, AerolineaState>(
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
                                    return 'Por favor ingrese el nombre';
                                  }
                                },
                                controller: txtNombre,
                                keyboardType: TextInputType.name,
                                textAlign: TextAlign.center,
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
                                      decoration: const InputDecoration(
                                          labelText: 'Código'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '*Error';
                                        }
                                      },
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: Text(''),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: TextFormField(
                                      controller: txtTelefono,
                                      maxLength: 8,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                          labelText: 'Teléfono'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor ingrese el teléfono';
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                controller: txtCorreo,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                validator: (Y) {
                                  return !state.isValidEmail
                                      ? "Ingrese un Correo Válido"
                                      : null;
                                },
                                decoration:
                                    const InputDecoration(labelText: 'Correo'),
                              ),
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
    txtNombre.clear();
    txtCorreo.clear();
    txtTelefono.clear();
    txtCodigo.clear();
  }

  void getUserrrr() async {
    usuario = await _repository!.getUser();
  }

  void _onEmailChanged() {
    _aerolineaBloc.add(EmailChanged(email: txtCorreo.text.trim()));
  }

  void _onSave() {
    DateTime now = DateTime.now();
    Aerolinea aerolinea = Aerolinea();
    aerolinea.nombre = txtNombre.text;
    aerolinea.codigo = txtCodigo.text;
    aerolinea.telefono = txtTelefono.text;
    aerolinea.correo = txtCorreo.text;
    aerolinea.estado = "1";
    aerolinea.fechaCre = now.toString();
    aerolinea.usuarioCrea = "";
    _aerolineaBloc.add(AddRegister(aerolinea: aerolinea));
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
