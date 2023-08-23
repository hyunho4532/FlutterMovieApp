import 'package:flutter/material.dart';

class ModifiedText extends StatelessWidget {

  final String text;
  final Color color;
  final double size;

  const ModifiedText({Key? key, required this.text, required this.color, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text (
      text,
      style: TextStyle (
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color,
      ),
    );
  }
}
