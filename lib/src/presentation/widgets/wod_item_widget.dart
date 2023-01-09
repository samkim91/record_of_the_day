import 'package:flutter/material.dart';
import 'package:way_to_fit/src/core/config/logger.dart';
import 'package:way_to_fit/src/data/models/wod.dart';

class WodItemWidget extends StatelessWidget {
  final Wod wod;
  final void Function(Wod wod) onClickWod;

  const WodItemWidget({Key? key, required this.wod, required this.onClickWod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: const Card(
        color: Colors.blueGrey,
      ),
    );
  }

  void _onTap() {
    logger.d('_onTap: ');
    onClickWod(wod);
  }
}
