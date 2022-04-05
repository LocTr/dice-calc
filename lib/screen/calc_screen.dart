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
                Expanded(
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                    crossAxisCount: 4,
                    // children: <Widget> [
                    //   TextButton(onPressed: () {}, child: Text('1'))
                    // ],
                    children: List.generate(16, (index) {
                      return TextButton(
                        onPressed: () {},
                        child: Text(index.toString()),
                      );
                    }),
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
