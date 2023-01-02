import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';
import 'package:way_to_fit/src/domain/entities/wod_type.dart';
import 'package:way_to_fit/src/injector.dart';
import 'package:way_to_fit/src/presentation/blocs/wod_create/wod_create_bloc.dart';

import '../../../core/config/logger.dart';

class WodCreateScreen extends StatelessWidget {
  const WodCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector.get<WodCreateBloc>(),
      child: Scaffold(appBar: AppBar(), body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildWodTypeSection(),
            const SizedBox(height: 20),
            _buildWodTypeSubSection(),
            const SizedBox(height: 20),
            _buildParticipationTypeSection(),
            const SizedBox(height: 20),
            _buildWodDetailsSection(),
            const SizedBox(height: 10),
            _buildWodDetailAddSection(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWodTypeSection() {
    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        return DropdownButton(
          value: state.wodType,
          items: WodType.values.map((WodType value) {
            return DropdownMenuItem<WodType>(
                value: value, child: Text(value.text));
          }).toList(),
          onChanged: (WodType? value) {
            BlocProvider.of<WodCreateBloc>(context).add(SelectWodType(value!));
          },
          isExpanded: true,
        );
      },
    );
  }

  Widget _buildWodTypeSubSection() {
    return const TextField(
      maxLines: 1,
      decoration: InputDecoration(
          border: OutlineInputBorder(), labelText: 'Time / Rounds / Etc'),
    );
  }

  Widget _buildParticipationTypeSection() {
    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        return Row(
          children: [
            ToggleButtons(
              isSelected: ParticipationType.values
                  .map((ParticipationType participationType) {
                return participationType == state.participationType;
              }).toList(),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onPressed: (int index) {
                logger.d('toggle selected: $index');
              },
              constraints: const BoxConstraints.expand(width: 80, height: 60),
              children: ParticipationType.values
                  .map((ParticipationType participationType) {
                return Text(participationType.text);
              }).toList(),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Members'),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildWodDetailsSection() {
    return Wrap(
      runSpacing: 4,
      children: [
        InputChip(
          padding: const EdgeInsets.all(7),
          label: const Center(child: Text('data 1')),
          avatar: const CircleAvatar(
            child: Text('1'),
          ),
          onDeleted: () {},
        ),
        InputChip(
          padding: const EdgeInsets.all(7),
          label: const Center(child: Text('data 2')),
          avatar: const CircleAvatar(
            child: Text('2'),
          ),
          onDeleted: () {},
        ),
        InputChip(
          padding: const EdgeInsets.all(7),
          label: const Center(child: Text('data 3')),
          avatar: const CircleAvatar(
            child: Text('3'),
          ),
          onDeleted: () {},
        ),
      ],
    );
  }

  Widget _buildWodDetailAddSection(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: () => _showWodDetailAddDialog(context),
      icon: const Icon(Icons.add),
      label: const Text('추가하기'),
    );
  }

  void _showWodDetailAddDialog(BuildContext context) {
    showDialog(context: context, builder: (context) =>
        CupertinoAlertDialog(
          title: const Text('동작을 입력하세요'),
          content: Column(
            children: const [
              SizedBox(height: 10),
              CupertinoTextField(
                placeholder: 'ex) 15 power snatch, 95lbs',
                clearButtonMode: OverlayVisibilityMode.editing,
                autofocus: true,
                padding: EdgeInsets.all(10),
                // decoration:
                //     InputDecoration(border: OutlineInputBorder(), labelText: 'action'),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(onPressed: () {
              Navigator.of(context).pop();
            }, child: const Text('취소')),
            CupertinoDialogAction(onPressed: () {}, child: const Text('저장')),
          ],
        ));
  }
}
