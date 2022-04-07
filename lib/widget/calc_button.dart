import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String childText;

  const CalcButton({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.childText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: Text(childText),
        ),
      ),
    );
  }
}
