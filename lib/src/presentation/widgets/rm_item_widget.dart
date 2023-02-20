import 'package:flutter/material.dart';
import 'package:way_to_fit/src/core/utils/calculator.dart';

import '../../data/models/rm.dart';

class RmItemWidget extends StatelessWidget {
  final Rm rm;
  final void Function() onClickItem;
  final bool isExpanded;
  final void Function() onClickExpand;

  const RmItemWidget(
      {Key? key,
      required this.rm,
      required this.onClickItem,
      this.isExpanded = false,
      required this.onClickExpand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return GestureDetector(
      onTap: () => onClickItem(),
      child: Card(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(rm.type.text, style: themeData.textTheme.titleLarge),
                    Text("${rm.result}",
                        style: themeData.textTheme.titleMedium),
                    IconButton(
                      icon: Icon(isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                      onPressed: () => onClickExpand(),
                    )
                  ],
                ),
                Visibility(
                  visible: isExpanded,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: calculatePercent(rm.result)
                        .map((e) => Text(e.toString()))
                        .toList(),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
