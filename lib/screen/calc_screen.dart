import 'package:flutter/material.dart';

class CalcScreen extends StatelessWidget {
  const CalcScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  '31',
                )
              ],
            ),
            MaterialButton(
              onPressed: () {},
              child: Text('asdfasdf'),
            ),
          ],
        ),
      ),
    );
  }
}
