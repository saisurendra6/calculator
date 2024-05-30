import 'package:flutter/material.dart';

const calcBtnEleList = [
  'AC', 'C', '%', '/', //
  '7', '8', '9', '*', //
  '4', '5', '6', '-', //
  '1', '2', '3', '+', //
  '.', '0', '( )', '=', //
];

class Button extends StatelessWidget {
  final String val;
  final VoidCallback callback;
  final Color color;
  const Button(
      {super.key,
      required this.val,
      required this.callback,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Text(
            val,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
