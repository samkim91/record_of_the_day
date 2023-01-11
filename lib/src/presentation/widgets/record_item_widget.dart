import 'package:flutter/material.dart';

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
      children: [
        Text("날짜"),
        Text("기록"),
        IconButton(
            onPressed: () => onClickMore(), icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}
