import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:way_to_fit/src/core/config/logger.dart';
import 'package:way_to_fit/src/core/config/network.dart';
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
    return BlocProvider(
      create: (context) => injector.get<WodListBloc>(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<WodListBloc, WodListState>(
      builder: (context, state) {
        scrollController.addListener(() => _onScroll(context));

        if (state.status.isInitial) {
          BlocProvider.of<WodListBloc>(context).add(const GetWods());
          return const SizedBox();
        }
        if (state.status.isError) {
          EasyLoading.dismiss();

          return Center(
            child: Text("Failed to load wods: ${state.error}"),
          );
        }

        state.status.isProcessing ? EasyLoading.show() : EasyLoading.dismiss();

        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.wods.length,
              itemBuilder: (context, index) {
                return WodItemWidget(
                    wod: state.wods[index],
                    onClickWod: () =>
                        _onClickWod(context, state.wods[index].id!));
              },
            ),
          ),
        );
      },
    );
  }

  void _onClickWod(BuildContext context, String id) {
    logger.d('_onClickWod: $id');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WodReadScreen(wodId: id)));
  }

  void _onScroll(BuildContext context) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final scrollDirection = scrollController.position.userScrollDirection;
    final wodListBloc = BlocProvider.of<WodListBloc>(context);
    final networkStatus = wodListBloc.state.status;

    final needToLoadMore = maxScroll - currentScroll < 100 &&
        (networkStatus.isInitial || networkStatus.isSuccess);

    if (needToLoadMore) {
      if (!wodListBloc.state.isMoreData &&
          scrollDirection == ScrollDirection.reverse) {
        EasyLoading.showInfo("No more data");
      } else {
        wodListBloc.add(const GetWods());
      }
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<WodListBloc>(context).add(const InitializeWods());
  }
}
