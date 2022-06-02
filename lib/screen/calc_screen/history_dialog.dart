import 'package:flutter/material.dart';

class HistoryDialog extends StatelessWidget {
  const HistoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(top: 200),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Text("There's no history yet")),
    );
  }
}
