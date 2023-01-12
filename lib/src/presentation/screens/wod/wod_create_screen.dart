import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/domain/entities/participation_type.dart';
import 'package:way_to_fit/src/domain/entities/wod_type.dart';
import 'package:way_to_fit/src/injector.dart';
import 'package:way_to_fit/src/presentation/blocs/wod/create/wod_create_bloc.dart';
import 'package:way_to_fit/src/presentation/screens/wod/wod_read_screen.dart';

class WodCreateScreen extends StatelessWidget {
  const WodCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector.get<WodCreateBloc>(),
      child: Scaffold(
          appBar: AppBar(
            actions: _buildAppBarActions(),
          ),
          body: _buildBody()),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      BlocBuilder<WodCreateBloc, WodCreateState>(
        builder: (context, state) {
          return TextButton(
            onPressed: () {
              BlocProvider.of<WodCreateBloc>(context).add(const SaveWod());
            },
            child: const Text("Save"),
          );
        },
      )
    ];
  }

  Widget _buildBody() {
    return BlocListener<WodCreateBloc, WodCreateState>(
      listener: (context, state) {
        if (state.status.isProcessing) {
          EasyLoading.show(status: "Saving...");
        }
        if (state.status.isSuccess) {
          EasyLoading.showSuccess("Saved!");

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WodReadScreen(wodId: state.wod.id!)));
        }
        if (state.status.isError) {
          EasyLoading.showError(state.error);
        }
        if (state.status.isInitial) {
          EasyLoading.dismiss();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              _buildWodSection(),
              const SizedBox(height: 12),
              _buildInstructionsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWodSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildParticipationTypeSection(),
            const SizedBox(height: 8),
            _buildWodTypeSection(),
            const SizedBox(height: 8),
            _buildWodTypeDetailSection(),
            const SizedBox(height: 12),
            _buildWodDetailsSection(),
            const SizedBox(height: 8),
            _buildWodDetailAddSection(),
          ],
        ),
      ),
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
                return participationType == state.wod.participationType;
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
            const SizedBox(width: 10),
            state.wod.participationType == ParticipationType.individual
                ? const SizedBox()
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

  Widget _buildWodTypeSection() {
    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        return DropdownButton(
          value: state.wod.type,
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

  Widget _buildWodTypeDetailSection() {
    TextEditingController textEditingController = TextEditingController();

    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        return TextField(
          controller: textEditingController,
          onChanged: (value) {
            BlocProvider.of<WodCreateBloc>(context)
                .add(TypeWodTypeDetail(value));
          },
          maxLines: 1,
          decoration: InputDecoration(
            suffixIcon: state.wod.typeDetail.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      BlocProvider.of<WodCreateBloc>(context)
                          .add(const TypeWodTypeDetail(""));
                      textEditingController.clear();
                    },
                  )
                : null,
            border: const OutlineInputBorder(),
            labelText: 'Time / Rounds / Etc',
            errorText: state.isValidTypeDetail ? null : 'Fill this form',
          ),
        );
      },
    );
  }

  Widget _buildWodDetailsSection() {
    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        final ThemeData themeData = Theme.of(context);

        return Column(
          children: [
            Text("Movements", style: themeData.textTheme.bodyLarge),
            Wrap(
              runSpacing: 1.0,
              children: state.wod.movements.asMap().entries.map((entry) {
                return InputChip(
                  backgroundColor: themeData.colorScheme.primary,
                  label: Center(child: Text(entry.value)),
                  onDeleted: () {
                    BlocProvider.of<WodCreateBloc>(context)
                        .add(ClickDeleteWodMovement(entry.key));
                  },
                );
              }).toList(),
            ),
          ],
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
                      .add(TypeWodMovement(value));
                },
                maxLines: 1,
                decoration: InputDecoration(
                    suffixIcon: state.movement.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              BlocProvider.of<WodCreateBloc>(context)
                                  .add(const TypeWodMovement(""));
                              textEditingController.clear();
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                    labelText: 'ex) 15 power snatch, 95lbs',
                    errorText: state.isValidMovements
                        ? null
                        : 'Insert at least one movement'),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {
                BlocProvider.of<WodCreateBloc>(context)
                    .add(AddWodMovement(state.movement));
                BlocProvider.of<WodCreateBloc>(context)
                    .add(const TypeWodMovement(""));
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

  Widget _buildInstructionsSection() {
    TextEditingController textEditingController = TextEditingController();

    return BlocBuilder<WodCreateBloc, WodCreateState>(
      builder: (context, state) {
        final ThemeData themeData = Theme.of(context);
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text("Instructions", style: themeData.textTheme.bodyLarge),
                const SizedBox(height: 8.0),
                TextField(
                  keyboardType: TextInputType.multiline,
                  controller: textEditingController,
                  onChanged: (value) {
                    BlocProvider.of<WodCreateBloc>(context)
                        .add(TypeInstructions(value));
                  },
                  maxLines: null,
                  decoration: InputDecoration(
                    suffixIcon: state.wod.instructions.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              BlocProvider.of<WodCreateBloc>(context)
                                  .add(const TypeInstructions(""));
                              textEditingController.clear();
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                    // labelText: 'Time / Rounds / Etc',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
