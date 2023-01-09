import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          actions: [],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
