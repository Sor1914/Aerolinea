import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/seat.dart';
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
  late AvionBloc _AvionBloc;

  final _formKey = GlobalKey<FormState>();
  var selectedCurrency;
  var items;
  var asientos;
  var idDocument;
  Seato seat = Seato(
      contador: 0,
      seleccionados: '',
      seleccionadosTemp: '',
      totalAsientos: 0,
      idDocumento: '');

  String occupiedSeat = "";
  bool isReset = false;
  List<DropdownMenuItem> currencyItems = [];
  AvionRepository? get _repository => widget._repository;

  @override
  void initState() {
    super.initState();
    _AvionBloc = BlocProvider.of<AvionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    String usuario;
    AvionRepository _repository = AvionRepository();
    UserRepository _userRepository = UserRepository();

    return BlocListener<AvionBloc, AvionState>(
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
                    Text('Cargando...'),
                    CircularProgressIndicator(),
                  ])));
            _AvionBloc.add(EmailChanged(email: ''));
          }
          if (state.isSuccess) {
            Navigator.pop(context);
            notificacion(context, 'Correcto', 'Los Datos Se Han Guardado', 0);
            Scaffold.of(context).hideCurrentSnackBar();
          }
        },
        child: BlocBuilder<AvionBloc, AvionState>(
            bloc: _AvionBloc,
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Tickets"),
                ),
                body: SingleChildScrollView(
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
                                DocumentSnapshot snap =
                                    snapshot.data!.documents[i];
                                currencyItems.add(DropdownMenuItem(
                                  value: snap.data()['asientos'] +
                                      '|' +
                                      snap.documentID,
                                  child: Text(
                                    snap.data()['modelo'],
                                  ),
                                ));
                              }
                            }
                            return Column(
                              children: <Widget>[
                                DropdownButtonFormField<dynamic>(
                                  decoration:
                                      const InputDecoration(labelText: 'Avión'),
                                  value: selectedCurrency,
                                  items: currencyItems,
                                  onChanged: (currencyValue) {
                                    setState(() {
                                      selectedCurrency = currencyValue;
                                      if (selectedCurrency != null) {
                                        seat.totalAsientos = int.parse(
                                            selectedCurrency.split('|')[0]);
                                        seat.idDocumento =
                                            selectedCurrency.split('|')[1];
                                        _onChange();
                                      } else {
                                        _onChange();
                                        asientos = 0;
                                        idDocument = '';
                                      }
                                    });
                                  },
                                ),
                                Row(
                                  children: const <Widget>[
                                    Expanded(child: Text(''))
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                        AirplaneSeats(
                            seatsQuantity: asientos ?? 0,
                            idDocument: idDocument ?? '',
                            color: Colors.green,
                            isReset: true,
                            seat: seat),
                      ],
                    )),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _onSave();
                  },
                  child: const Icon(Icons.add),
                ),

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

  void _onSave() {
    DateTime now = DateTime.now();

    _AvionBloc.add(SaveTicket(idDocumento: '', seat: seat));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        //pasar a la otra pantalla
      }
    });
  }

  void _onChange() {
    _AvionBloc.add(AvionChange(idDocumento: idDocument, seat: seat));
  }
}
