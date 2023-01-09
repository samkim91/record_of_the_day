import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:way_to_fit/src/core/config/logger.dart';
import 'package:way_to_fit/src/data/models/wod.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';

class WodItemWidget extends StatelessWidget {
  final Wod wod;
  final void Function() onClickWod;

  const WodItemWidget({Key? key, required this.wod, required this.onClickWod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return GestureDetector(
      onTap: _onTap,
      child: Card(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionChip(
                        label: wod.participationType ==
                                ParticipationType.individual
                            ? Text(wod.participationType.text)
                            : Text(
                                "${wod.participationType.text} of ${wod.memberCount}")),
                    Text("${wod.type.text} - ${wod.typeDetail}",
                        style: themeData.textTheme.titleMedium),
                    Text(DateFormat("yy.MM.dd").format(wod.createdAt!)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: wod.movements.map((e) => Text("- $e")).toList(),
                ),
              ],
            ),
          )),
    );
  }

  void _onTap() {
    logger.d('_onTap: ');
    onClickWod();
  }
}
