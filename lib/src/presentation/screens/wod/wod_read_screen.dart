import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';
import 'package:way_to_fit/src/injector.dart';
import 'package:way_to_fit/src/presentation/blocs/wod/read/wod_read_bloc.dart';
import 'package:way_to_fit/src/presentation/blocs/wod/record/list/record_list_bloc.dart';
import 'package:way_to_fit/src/presentation/widgets/record_item_widget.dart';
import 'package:way_to_fit/src/presentation/widgets/record_save_bottom_sheet.dart';

class WodReadScreen extends StatelessWidget {
  final String wodId;

  const WodReadScreen({
    Key? key,
    required this.wodId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector.get<WodReadBloc>(),
        ),
        BlocProvider(
          create: (context) => injector.get<RecordListBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
            // actions: _buildAppBarActions(),
            ),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      BlocBuilder<WodReadBloc, WodReadState>(
        builder: (context, state) {
          return Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          );
        },
      ),
    ];
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<RecordListBloc, RecordListState>(
      builder: (context, state) {
        return FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              builder: (context) {
                return RecordSaveBottomSheet(wodId: wodId);
              },
            ).then((value) => BlocProvider.of<RecordListBloc>(context)
                .add(GetRecords(wodId)));
          },
        );
      },
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildWodSection(),
            const SizedBox(height: 12),
            _buildRecordsSection(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildWodSection() {
    return BlocBuilder<WodReadBloc, WodReadState>(
      builder: (context, state) {
        if (state.status.isInitial) {
          BlocProvider.of<WodReadBloc>(context).add(GetWod(wodId));

          return const SizedBox();
        }

        if (state.status.isError) {
          EasyLoading.dismiss();

          return Center(
            child: Text("Failed to load wod: ${state.error}"),
          );
        }

        if (state.status.isProcessing) {
          EasyLoading.show();

          return const SizedBox();
        }

        EasyLoading.dismiss();

        return Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _buildParticipationTypeSection(),
                    _buildWodTypeSection(),
                    const SizedBox(height: 8),
                    _buildWodDetailsSection(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildInstructionsSection(),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildParticipationTypeSection() {
    return BlocBuilder<WodReadBloc, WodReadState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerLeft,
          child: ActionChip(
              label: Text(state.wod.participationType ==
                      ParticipationType.individual
                  ? state.wod.participationType.text
                  : "${state.wod.participationType.text} of ${state.wod.memberCount}")),
        );
      },
    );
  }

  Widget _buildWodTypeSection() {
    return BlocBuilder<WodReadBloc, WodReadState>(builder: (context, state) {
      return TextField(
        controller: TextEditingController(
            text: "${state.wod.type.text} ${state.wod.typeDetail}"),
        enabled: false,
      );
    });
  }

  Widget _buildWodDetailsSection() {
    return BlocBuilder<WodReadBloc, WodReadState>(
      builder: (context, state) {
        final ThemeData themeData = Theme.of(context);

        return Column(
          children: state.wod.movements.asMap().entries.map((entry) {
            return Align(
                alignment: Alignment.centerLeft,
                child: Text("- ${entry.value}",
                    style: themeData.textTheme.bodyLarge));
          }).toList(),
        );
      },
    );
  }

  Widget _buildInstructionsSection() {
    return BlocBuilder<WodReadBloc, WodReadState>(builder: (context, state) {
      final ThemeData themeData = Theme.of(context);

      return Column(
        children: [
          Text("Instructions", style: themeData.textTheme.bodyLarge),
          TextField(
            controller: TextEditingController(text: state.wod.instructions),
            enabled: false,
            maxLines: null,
          ),
        ],
      );
    });
  }

  Widget _buildRecordsSection() {
    return BlocBuilder<RecordListBloc, RecordListState>(
      builder: (context, state) {
        final ThemeData themeData = Theme.of(context);

        if (state.status.isInitial) {
          BlocProvider.of<RecordListBloc>(context).add(GetRecords(wodId));

          return const SizedBox();
        }

        if (state.status.isError) {
          return Center(
            child: Text("Failed to load records: ${state.error}"),
          );
        }

        if (state.status.isProcessing) {
          return const SizedBox();
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text("Records", style: themeData.textTheme.bodyLarge),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.records.length,
                    itemBuilder: (context, index) {
                      return RecordItemWidget(
                          record: state.records[index],
                          onClickMore: () => _onClickMore());
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onClickMore() {}
}
