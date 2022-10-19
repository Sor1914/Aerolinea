import 'package:aerolinea/src/models/seat.dart';
import 'package:aerolinea/src/ui/tickets/seat.dart';
import 'package:flutter/material.dart';

class AirplaneSeats extends StatelessWidget {
  final int _seatsQuantity;
  final List<Widget> columnChildren = [];
  Color _color;
  final String _idDocument;
  final bool _isReset;
  final Seato _seat;
  AirplaneSeats(
      {super.key,
      required int seatsQuantity,
      required color,
      required idDocument,
      required isReset,
      required seat})
      : _seatsQuantity = seatsQuantity,
        _color = color,
        _idDocument = idDocument,
        _isReset = isReset,
        _seat = seat;
  @override
  Widget build(BuildContext context) {
    _fillSeats();
    return Column(
      children: columnChildren,
    );
  }

  void _fillSeats() {
    var ocuppiedSeats = _seat.seleccionados.toString().split('|');
    bool isDisabled = false;
    int internalSeatCounter = 3;
    int seatNumber = 1;
    int seatIndex = 0;
    List<Widget> currentSeatRow = [];
    while (seatNumber <= _seatsQuantity) {
      seatIndex++;
      if (seatIndex == internalSeatCounter) {
        currentSeatRow.add(SizedBox.fromSize(
          size: const Size(40, 40),
        ));
        internalSeatCounter += 5;
        continue;
      }
      if (ocuppiedSeats.isNotEmpty) {
        for (var element in ocuppiedSeats) {
          if (element != "") {
            if (int.parse(element) == seatNumber) {
              isDisabled = true;
              break;
            } else {
              isDisabled = false;
            }
          }
        }
      } else {
        isDisabled = false;
      }

      currentSeatRow.add(Seat(
        number: seatNumber,
        idDocument: _idDocument,
        isDisabled: isDisabled,
        isReset: _isReset,
        seat: _seat,
      ));

      if (internalSeatCounter - 3 == seatIndex ||
          seatNumber == _seatsQuantity) {
        if (seatNumber == _seatsQuantity && seatNumber % 2 != 0) {
          //Se agrega un espacio vacío para que se vea ordenado
          currentSeatRow.add(SizedBox.fromSize(size: const Size(40, 40)));
        }
        columnChildren.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: currentSeatRow));
        columnChildren.add(const Divider(height: 4, color: Colors.transparent));
        currentSeatRow = [];
      }

      seatNumber++;
    }
  }
}
