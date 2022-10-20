import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/avion.dart';
import '../../models/seat.dart';
import '../../repository/avion_repository.dart';

class Seat extends StatefulWidget {
  final int _number;
  final String _idDocument;
  final bool _isDisabled;
  final bool _isReset;
  final Seato _seat;
  const Seat(
      {Key? key,
      required int number,
      required idDocument,
      required isDisabled,
      required isReset,
      required seat})
      : _number = number,
        _idDocument = idDocument,
        _isDisabled = isDisabled,
        _isReset = isReset,
        _seat = seat,
        super(key: key);
  @override
  State<Seat> createState() => _SeatState(
        idDocument: _idDocument,
        number: _number,
        isDisabled: _isDisabled,
        isReset: _isReset,
        seat: _seat,
      );
}

class _SeatState extends State<Seat> {
  final int _number;
  final String _idDocument;
  Color color = Colors.green;
  final bool _isDisabled;
  final bool _isReset;
  final Seato _seat;
  bool prueba = false;
  _SeatState(
      {Key? key,
      required int number,
      required idDocument,
      required isReset,
      required isDisabled,
      required seat})
      : _number = number,
        _idDocument = idDocument,
        _isReset = isReset,
        _isDisabled = isDisabled,
        _seat = seat,
        super();

  AvionRepository _repository = AvionRepository();

  @override
  Widget build(BuildContext context) {
    prueba = false;
    var ocuppiedSeats = _seat.seleccionados.toString().split('|');
    if (ocuppiedSeats.isNotEmpty) {
      for (var element in ocuppiedSeats) {
        if (element != "") {
          if (int.parse(element) == _number) {
            prueba = true;
            break;
          } else {
            prueba = false;
          }
        }
      }
    } else {
      prueba = false;
    }
    var seleccion = _seat.seleccionados.split('|');
    return SizedBox.fromSize(
      size: const Size(70, 70),
      child: Container(
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: color, onPrimary: Colors.white),
          onPressed: prueba
              ? null
              : () {
                  setState(() {
                    Scaffold.of(context).hideCurrentSnackBar();
                    if (color == Colors.red) {
                      color = Colors.green;
                      _seat.seleccionadosTemp =
                          _seat.seleccionadosTemp.replaceAll("|$_number", "");
                      _seat.contador -= 1;
                    } else {
                      color = Colors.red;
                      _seat.seleccionadosTemp += '|$_number';
                      _seat.contador += 1;
                    }

                    final snackBar = SnackBar(
                        content: Text('seleccionados: ${_seat.contador}'));
                    Scaffold.of(context).showSnackBar(snackBar);
                    Avion avion =
                        Avion(listaAsientosTemp: _seat.seleccionadosTemp);
                    _repository.updSeatTemporal(
                        avion: avion, idDocumento: _seat.idDocumento);
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
