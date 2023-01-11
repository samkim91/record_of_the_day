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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(DateFormat("yy/M/dd").format(record.createdAt!)),
        Text(record.result),
        IconButton(
            onPressed: () => onClickMore(), icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}
