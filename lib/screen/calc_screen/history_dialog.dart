import 'package:dice_calc/bloc/history_cubit/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryDialog extends StatelessWidget {
  const HistoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> getDataToList() {
      Map data = context.read<HistoryCubit>().state.data;

      var resultList = <Widget>[];
      var lastValue = '';

      data.forEach((key, value) {
        String equator = value[0];
        String result = value[1];
        resultList.add(ArchiveRow(
          header: (lastValue != equator) ? equator : null,
          text: result,
        ));
        lastValue = equator;
      });
      return resultList;
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
                  padding: const EdgeInsets.all(20),
                  physics: const ClampingScrollPhysics(),
                  children: getDataToList(),
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.read<HistoryCubit>().clear();
                  },
                  icon: const Icon(Icons.delete_outline)),
            ],
          )),
    );
  }
}

class ArchiveRow extends StatelessWidget {
  final String? header;
  final String text;
  const ArchiveRow({
    Key? key,
    this.header,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (header != null)
          const SizedBox(
            height: 10,
          ),
        if (header != null)
          Text(
            '$header =',
            textScaleFactor: 0.7,
            style: Theme.of(context).textTheme.headline3,
          ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
