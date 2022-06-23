import 'package:dice_calc/logic/persistence/historyDB.dart';
import 'package:flutter/material.dart';

class HistoryDialog extends StatelessWidget {
  const HistoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> getDataToList() {
      Map data = HistoryDB.readAll();
      var result = <Widget>[];

      data.forEach((key, value) {
        result.add(Text(value[0]));
        result.add(Text(value[1]));
      });
      return result;
    }

    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(top: 200),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: getDataToList(),
                ),
              ),
              IconButton(
                  onPressed: () {
                    HistoryDB.clear();
                  },
                  icon: const Icon(Icons.delete_outline)),
            ],
          )),
    );
  }
}
