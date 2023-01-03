import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';
import 'package:way_to_fit/src/domain/entities/wod_type.dart';
import 'package:way_to_fit/src/injector.dart';
import 'package:way_to_fit/src/presentation/blocs/wod_create/wod_create_bloc.dart';

class WodCreateScreen extends StatelessWidget {
  const WodCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector.get<WodCreateBloc>(),
      child: Scaffold(appBar: AppBar(), body: _buildBody()),
    );
  }

  Widget _buildBody() {
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
            const Text('Movements'),
            const SizedBox(height: 10),
            _buildWodDetailsSection(),
            const SizedBox(height: 10),
            _buildWodDetailAddSection(),
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
                value: value, child: Center(child: Text(value.text)));
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
    TextEditingController textEditingController = TextEditingController();

    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        return TextField(
          controller: textEditingController,
          onChanged: (value) {
            BlocProvider.of<WodCreateBloc>(context).add(TypeWodTypeSub(value));
          },
          maxLines: 1,
          decoration: InputDecoration(
              suffixIcon: state.wodTypeSub.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        BlocProvider.of<WodCreateBloc>(context)
                            .add(const TypeWodTypeSub(''));
                        textEditingController.clear();
                      },
                    )
                  : null,
              border: const OutlineInputBorder(),
              labelText: 'Time / Rounds / Etc'),
        );
      },
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
              constraints: const BoxConstraints.expand(height: 60, width: 80),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onPressed: (int index) {
                BlocProvider.of<WodCreateBloc>(context).add(
                    SelectParticipationType(ParticipationType.values[index]));
              },
              children: ParticipationType.values
                  .map((ParticipationType participationType) {
                return Text(participationType.text);
              }).toList(),
            ),
            state.participationType == ParticipationType.individual
                ? Container()
                : const SizedBox(width: 10),
            // const SizedBox(width: 10),
            state.participationType == ParticipationType.individual
                ? Container()
                : Expanded(
                    child: TextField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Members'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4)
                      ],
                      onChanged: (value) {
                        BlocProvider.of<WodCreateBloc>(context).add(
                            TypeMemberCount(
                                value.isNotEmpty ? int.parse(value) : 0));
                      },
                    ),
                  )
          ],
        );
      },
    );
  }

  Widget _buildWodDetailsSection() {
    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        final ColorScheme colors = Theme.of(context).colorScheme;

        return Wrap(
          children: state.wodDetails.asMap().entries.map((entry) {
            return InputChip(
              // padding: const EdgeInsets.all(7),
              label: Center(child: Text(entry.value)),
              avatar: CircleAvatar(
                foregroundColor: colors.onPrimary,
                backgroundColor: colors.primary,
                child: Text(
                  (entry.key + 1).toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: colors.onPrimary),
                ),
              ),
              onDeleted: () {
                BlocProvider.of<WodCreateBloc>(context)
                    .add(ClickDeleteWodDetail(entry.key));
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildWodDetailAddSection() {
    TextEditingController textEditingController = TextEditingController();

    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        final ColorScheme colors = Theme.of(context).colorScheme;

        return Row(
          children: [
            Flexible(
              child: TextField(
                controller: textEditingController,
                onChanged: (value) {
                  BlocProvider.of<WodCreateBloc>(context)
                      .add(TypeWodDetail(value));
                },
                maxLines: 1,
                decoration: InputDecoration(
                    suffixIcon: state.wodDetail.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              BlocProvider.of<WodCreateBloc>(context)
                                  .add(const TypeWodDetail(''));
                              textEditingController.clear();
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                    labelText: 'ex) 15 power snatch, 95lbs'),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {
                BlocProvider.of<WodCreateBloc>(context)
                    .add(AddWodDetail(state.wodDetail));
                BlocProvider.of<WodCreateBloc>(context)
                    .add(const TypeWodDetail(''));
                textEditingController.clear();
              },
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                foregroundColor: colors.onPrimary,
                backgroundColor: colors.primary,
              ),
            ),
          ],
        );
      },
    );
  }
}
