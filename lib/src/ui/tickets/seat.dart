import 'package:flutter/material.dart';

import '../../models/avion.dart';
import '../../repository/avion_repository.dart';

class Seat extends StatelessWidget {
  final int _number;
  final Color _color;
  final String _numbers;
  final String _idDocument;
  Seat(
      {Key? key,
      required int number,
      required color,
      required numbers,
      required idDocument})
      : _number = number,
        _color = color,
        _numbers = numbers,
        _idDocument = idDocument;
  AvionRepository _repository = AvionRepository();
  @override
  Widget build(BuildContext context) {
    Color color = _color;
    return SizedBox.fromSize(
      size: const Size(50, 50),
      child: Container(
          child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: color, onPrimary: Colors.white),
        onPressed: isSelected(_color)
            ? () {
                Avion avion =
                    Avion(listaAsientos: _numbers + '|' + _number.toString());
                _repository.updAvion(avion: avion, idDocumento: _idDocument);
                Scaffold.of(context).hideCurrentSnackBar();
                color = _color;
                final snackBar = SnackBar(
                    content: Text('Número presionado ${_number.toString()}'));
                Scaffold.of(context).showSnackBar(snackBar);
              }
            : null,
        child: Text(_number.toString()),
      )),
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
