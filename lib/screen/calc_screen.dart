import 'package:dice_calc/widget/calc_button.dart';
import 'package:flutter/material.dart';

class CalcScreen extends StatelessWidget {
  const CalcScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 200.0,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        '64',
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: const [
                      Expanded(
                          child: CalcButton(
                        childText: '0',
                      )),
                      Expanded(
                          child: CalcButton(
                        childText: '.',
                      )),
                      Expanded(
                          child: CalcButton(
                        childText: '=',
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
