import 'package:flutter/material.dart';
import 'package:way_to_fit/src/data/models/wod.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';

class WodItemWidget extends StatelessWidget {
  final Wod wod;
  final void Function() onClickItem;

  const WodItemWidget({Key? key, required this.wod, required this.onClickItem})
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
                  children: [
                    ActionChip(
                        label: wod.participationType ==
                                ParticipationType.individual
                            ? Text(wod.participationType.text)
                            : Text(
                                "${wod.participationType.text} of ${wod.memberCount}")),
                    const SizedBox(width: 10),
                    Text("${wod.type.text} ${wod.typeDetail}",
                        style: themeData.textTheme.titleMedium),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: wod.movements
                      .map((e) =>
                          Text("- $e", style: themeData.textTheme.bodyLarge))
                      .toList(),
                ),
              ],
            ),
          )),
    );
  }
}
