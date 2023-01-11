import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/injector.dart';

import '../../data/models/record.dart';
import '../blocs/wod/record/create/record_create_bloc.dart';

class RecordSaveBottomSheet extends StatelessWidget {
  final String wodId;
  final Record? record;

  const RecordSaveBottomSheet({
    Key? key,
    required this.wodId,
    this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector.get<RecordCreateBloc>(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    TextEditingController resultEditingController = TextEditingController();
    TextEditingController memoEditingController = TextEditingController();

    return BlocBuilder<RecordCreateBloc, RecordCreateState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          EasyLoading.showSuccess("Saved!");
          Future.delayed(const Duration(milliseconds: 1000));
          Navigator.pop(context);
        }

        return Container(
          padding: EdgeInsets.fromLTRB(
              20, 30, 20, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: resultEditingController,
                onChanged: (value) {
                  BlocProvider.of<RecordCreateBloc>(context)
                      .add(TypeResult(value));
                },
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: state.record.result.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            BlocProvider.of<RecordCreateBloc>(context)
                                .add(TypeResult(""));
                            resultEditingController.clear();
                          },
                        )
                      : null,
                  border: const OutlineInputBorder(),
                  labelText: "Result",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.multiline,
                controller: memoEditingController,
                onChanged: (value) {
                  BlocProvider.of<RecordCreateBloc>(context)
                      .add(TypeMemo(value));
                },
                maxLines: 3,
                decoration: InputDecoration(
                  suffixIcon: state.record.memo.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            BlocProvider.of<RecordCreateBloc>(context)
                                .add(TypeMemo(""));
                            memoEditingController.clear();
                          },
                        )
                      : null,
                  border: const OutlineInputBorder(),
                  hintText: "Memo",
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<RecordCreateBloc>(context)
                        .add(SaveRecord(wodId, record));
                  },
                  child: const Text("Save"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
