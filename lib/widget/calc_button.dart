import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String childText;
  final double aspectRatio;
  final double textScaleFactor;

  const CalcButton({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.childText = '',
    this.aspectRatio = 1.2,
    this.textScaleFactor = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Text(
          childText,
          textScaleFactor: textScaleFactor,
        ),
      ),
    );
  }
}
