import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text('setting screen placeholder'),
            FutureBuilder(
              future: Hive.openBox('history'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) return Text(snapshot.error.toString());
                  return const Text('box content');
                } else {
                  return const Text('loading');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
