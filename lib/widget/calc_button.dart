import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String childText;
  final double aspectRatio;
  final double textScaleFactor;
  final Widget? child;
  final ButtonStyle? style;

  const CalcButton({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.childText = '',
    this.child,
    this.aspectRatio = 1.2,
    this.textScaleFactor = 1.5,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: TextButton.styleFrom(backgroundColor: Colors.grey[100]),
          child: child ??
              Text(
                childText,
                textScaleFactor: textScaleFactor,
              ),
        ),
      ),
    );
  }
}
