import 'package:aerolinea/src/ui/tickets/seat.dart';
import 'package:flutter/material.dart';

class AirplaneSeats extends StatelessWidget {
  final int _seatsQuantity;
  final List<Widget> columnChildren = [];

  AirplaneSeats({super.key, required int seatsQuantity})
      : _seatsQuantity = seatsQuantity;

  @override
  Widget build(BuildContext context) {
    _fillSeats();
    return Column(
      children: columnChildren,
    );
  }

  void _fillSeats() {
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
      currentSeatRow.add(Seat(number: seatNumber));

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
