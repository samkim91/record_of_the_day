import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/record.dart';

class RecordItemWidget extends StatelessWidget {
  final Record record;
  final void Function() onClickMore;

  const RecordItemWidget(
      {Key? key, required this.record, required this.onClickMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat("yy/M/dd").format(record.createdAt!)),
              Text(record.result),
              IconButton(
                  onPressed: () => onClickMore(),
                  icon: const Icon(Icons.more_vert)),
            ],
          ),
          const Divider(
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
