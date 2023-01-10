import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';
import 'package:way_to_fit/src/injector.dart';
import 'package:way_to_fit/src/presentation/blocs/wod/read/wod_read_bloc.dart';

class WodReadScreen extends StatelessWidget {
  final String wodId;

  const WodReadScreen({
    Key? key,
    required this.wodId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector.get<WodReadBloc>(),
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

  Widget _buildBody() {
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

        return Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildParticipationTypeSection(),
              const SizedBox(height: 10),
              _buildWodTypeSection(),
              const SizedBox(height: 30),
              _buildWodDetailsTitleSection(),
              const SizedBox(height: 10),
              _buildWodDetailsSection(),
              const SizedBox(height: 30),
              _buildRecordsSection(),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
        child: const Icon(Icons.add), onPressed: () => {});
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

  Widget _buildWodDetailsTitleSection() {
    return BlocBuilder<WodReadBloc, WodReadState>(
      builder: (context, state) {
        final ThemeData themeData = Theme.of(context);

        return Container(
          decoration: BoxDecoration(
              color: themeData.colorScheme.onTertiaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
          child: Text("Movements",
              style: themeData.textTheme.bodyLarge
                  ?.copyWith(color: themeData.colorScheme.onPrimary)),
        );
      },
    );
  }

  Widget _buildWodDetailsSection() {
    return BlocBuilder<WodReadBloc, WodReadState>(
      builder: (context, state) {
        final ThemeData themeData = Theme.of(context);

        return Wrap(
          runSpacing: 1.0,
          children: state.wod.movements.asMap().entries.map((entry) {
            return ActionChip(
              // padding: const EdgeInsets.all(7),
              label: Center(child: Text(entry.value)),
              avatar: CircleAvatar(
                foregroundColor: themeData.colorScheme.onPrimary,
                backgroundColor: themeData.colorScheme.primary,
                child: Text(
                  (entry.key + 1).toString(),
                  style: themeData.textTheme.labelSmall
                      ?.copyWith(color: themeData.colorScheme.onPrimary),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildRecordsSection() {
    return const SizedBox();
  }
}
