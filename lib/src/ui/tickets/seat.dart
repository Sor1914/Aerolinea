import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/avion.dart';
import '../../repository/avion_repository.dart';

class Seat extends StatefulWidget {
  final int _number;
  final String _numbers;
  final String _idDocument;
  final bool _isDisabled;
  final bool _isReset;
  const Seat(
      {Key? key,
      required int number,
      required numbers,
      required idDocument,
      required isDisabled,
      required isReset})
      : _number = number,
        _numbers = numbers,
        _idDocument = idDocument,
        _isDisabled = isDisabled,
        _isReset = isReset,
        super(key: key);
  @override
  State<Seat> createState() => _SeatState(
      idDocument: _idDocument,
      number: _number,
      numbers: _numbers,
      isDisabled: _isDisabled,
      isReset: _isReset);
}

String seleccionados = '';
int contador = 0;

class _SeatState extends State<Seat> {
  final int _number;
  final String _numbers;
  final String _idDocument;
  Color color = Colors.green;
  final bool _isDisabled;
  final bool _isReset;
  _SeatState(
      {Key? key,
      required int number,
      required numbers,
      required idDocument,
      required isReset,
      required isDisabled})
      : _number = number,
        _numbers = numbers,
        _idDocument = idDocument,
        _isReset = isReset,
        _isDisabled = isDisabled,
        super();

  AvionRepository _repository = AvionRepository();

  @override
  Widget build(BuildContext context) {
    if (_isReset) {
      seleccionados = '';
    } else {
      contador = 0;
    }
    return SizedBox.fromSize(
      size: const Size(70, 70),
      child: Container(
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: color, onPrimary: Colors.white),
          onPressed: _isDisabled
              ? null
              : () {
                  setState(() {
                    Scaffold.of(context).hideCurrentSnackBar();
                    if (color == Colors.red) {
                      color = Colors.green;
                      seleccionados = seleccionados.replaceAll("|$_number", "");
                      contador -= 1;
                    } else {
                      color = Colors.red;
                      seleccionados += '|$_number';
                      contador += 1;
                    }
                    final snackBar =
                        SnackBar(content: Text('seleccionados: $contador'));
                    Scaffold.of(context).showSnackBar(snackBar);
                    Avion avion = Avion(listaAsientosTemp: seleccionados);
                    _repository.updAvion(
                        avion: avion, idDocumento: _idDocument);
                  });
                  //  Avion avion = Avion(listaAsientos: _numbers + '|' + _number.toString());
                  //_repository.updAvion(avion: avion, idDocumento: _idDocument);
                },
          child: Text(_number.toString()),
        ),
      ),
    );
  }

  static bool isSelected(Color color) {
    if (color == Colors.red) {
      return false;
    } else {
      return true;
    }
  }
}
