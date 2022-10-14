import 'package:flutter/material.dart';

class Seat extends StatelessWidget {
  const Seat({super.key, required int number}) : _number = number;

  final int _number;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(40, 40),
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Text(_number.toString()),
        ),
      ),
    );
  }
}
