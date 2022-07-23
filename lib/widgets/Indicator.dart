import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color _color;
  final String _text;
  final double _size;
  final Color _textColor;

  const Indicator({
    Key? key,
    required Color color,
    required String text,
    double size = 16,
    Color textColor = const Color(0xff505050),
  })  : _color = color,
        _text = text,
        _size = size,
        _textColor = textColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          _text,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: _textColor),
        )
      ],
    );
  }
}
