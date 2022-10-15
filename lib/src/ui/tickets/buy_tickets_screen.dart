import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../AgregarAvion.dart';
import 'airplane_seats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aerolinea/src/blocs/avion_bloc/bloc.dart';
import 'package:aerolinea/src/models/avion.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:aerolinea/src/repository/avion_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/aerolinea.dart';
import '../AgregarAvion.dart';

class BuyTicketScreen extends StatelessWidget {
  @override
  final AvionRepository _repository;
  final UserRepository _userRepository;

  BuyTicketScreen(
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
            child: BuyTicketForm(
              repository: _repository,
              userRepository: _userRepository,
            )));
  }
}

class BuyTicketForm extends StatefulWidget {
  final AvionRepository? _repository;
  final UserRepository _userRepository;
  BuyTicketForm(
      {Key? key,
      required AvionRepository repository,
      required UserRepository userRepository})
      : assert(repository != null),
        _repository = repository,
        _userRepository = UserRepository(),
        super(key: key);

  @override
  _BuyTicketFormState createState() => _BuyTicketFormState();
}

final _auth = FirebaseAuth.instance;

class _BuyTicketFormState extends State<BuyTicketForm> {
  String usuario = "No encontrado";
  int _selectedIndex = 0;
  final txtNombre = TextEditingController();
  final txtCorreo = TextEditingController();
  final txtTelefono = TextEditingController();
  final txtCodigo = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late AvionBloc _aerolineaBloc;
  var selectedCurrency;
  var items;
  var asientos;
  var idDocument;
  var occupiedSeat;
  List<DropdownMenuItem> currencyItems = [];
  AvionRepository? get _repository => widget._repository;

  @override
  void initState() {
    super.initState();
    _aerolineaBloc = BlocProvider.of<AvionBloc>(context);
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
    }, child: BlocBuilder<AvionBloc, AvionState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tickets"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("avion")
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                    } else {
                      currencyItems = [];
                      for (int i = 0;
                          i < snapshot.data!.documents.length;
                          i++) {
                        DocumentSnapshot snap = snapshot.data!.documents[i];
                        currencyItems.add(DropdownMenuItem(
                          value: snap.data()['asientos'] +
                              '|' +
                              snap.documentID +
                              '[' +
                              snap.data()['listaAsientos'],
                          child: Text(
                            snap.data()['modelo'],
                          ),
                        ));
                      }
                    }
                    return Column(
                      children: <Widget>[
                        DropdownButtonFormField<dynamic>(
                          decoration: const InputDecoration(labelText: 'Avión'),
                          value: selectedCurrency,
                          items: currencyItems,
                          onChanged: (currencyValue) {
                            AvionState.success();
                            setState(() {
                              selectedCurrency = currencyValue;
                              if (selectedCurrency != null) {
                                asientos =
                                    int.parse(selectedCurrency.split('|')[0]);
                                idDocument = selectedCurrency
                                    .split('[')[0]
                                    .split('|')[1];
                                occupiedSeat = selectedCurrency.split('[')[1];
                              } else {
                                asientos = 0;
                                idDocument = '';
                              }
                            });
                          },
                        ),
                        Row(
                          children: const <Widget>[Expanded(child: Text(''))],
                        ),
                        AirplaneSeats(
                            seatsQuantity: asientos ?? 0,
                            idDocument: idDocument ?? '',
                            numbers: occupiedSeat ?? '',
                            color: Colors.green),
                      ],
                    );
                  }),
                ),
              ],
            )),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
    }));
  }

  void limpiarCampos() {
    txtNombre.clear();
    txtCorreo.clear();
    txtTelefono.clear();
    txtCodigo.clear();
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
