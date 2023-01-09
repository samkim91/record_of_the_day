import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:way_to_fit/src/core/config/logger.dart';
import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/data/models/wod.dart';
import 'package:way_to_fit/src/injector.dart';
import 'package:way_to_fit/src/presentation/blocs/wod/list/wod_list_bloc.dart';
import 'package:way_to_fit/src/presentation/screens/wod/wod_read_screen.dart';
import 'package:way_to_fit/src/presentation/widgets/wod_item_widget.dart';

class WodListScreen extends StatelessWidget {
  final ScrollController scrollController;

  const WodListScreen({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() => _onScroll(context));

    return BlocProvider(
      create: (context) => injector.get<WodListBloc>(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<WodListBloc, WodListState>(
      builder: (context, state) {
        if (state.status.isInitial) {
          EasyLoading.show();
          BlocProvider.of<WodListBloc>(context).add(const GetWods());

          return Container();
        }
        if (state.status.isError) {
          EasyLoading.dismiss();

          return Center(
            child: Text("Failed to load wods: ${state.error}"),
          );
        }
        if (state.status.isSuccess) {
          EasyLoading.dismiss();

          return Scrollbar(
              child: ListView(
            controller: scrollController,
            children: [
              WodItemWidget(
                wod: const Wod(),
                onClickWod: (_) => _onClickWod(context, ""),
              ),
              WodItemWidget(
                wod: const Wod(),
                onClickWod: (_) => _onClickWod(context, ""),
              ),
              WodItemWidget(
                wod: const Wod(),
                onClickWod: (_) => _onClickWod(context, ""),
              ),
            ],
          ));
        }
        EasyLoading.show();
        return Container();
      },
    );
  }

  void _onClickWod(BuildContext context, String id) {
    logger.d('_onClickWod: ');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WodReadScreen(wodId: id)));
  }

  void _onScroll(BuildContext context) {
    logger.d('_onScroll: ');
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final wodListBloc = BlocProvider.of<WodListBloc>(context);
    final networkStatus = wodListBloc.state.status;

    final needToLoadMore = maxScroll - currentScroll <= 200.0 &&
        (networkStatus.isInitial || networkStatus.isSuccess);

    if (needToLoadMore) {
      wodListBloc.add(const GetWods());
    }
  }
}
