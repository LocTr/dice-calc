import 'package:flutter/material.dart';

class ChipButton extends StatelessWidget {
  final Function()? onTap;
  final String label;

  const ChipButton({Key? key, this.onTap, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(label),
      onPressed: onTap,
    );
  }
}
