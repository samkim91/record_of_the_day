import 'package:flutter/material.dart';
import 'package:way_to_fit/src/presentation/widgets/wod_item_widget.dart';

class WodsScreen extends StatelessWidget {
  const WodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scrollbar(
        child: ListView(
      controller: scrollController,
      children: const [
        WodItemWidget(),
        WodItemWidget(),
        WodItemWidget(),
      ],
    ));
  }
}
