import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/presentation/blocs/auth/auth_bloc.dart';

import '../../injector.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => injector.get<AuthBloc>(),
        child: Scaffold(body: _buildBody()));
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _logoSection(),
          const SizedBox(height: 100),
          _emailSection(),
        ],
      ),
    );
  }

  Widget _logoSection() {
    return ConstrainedBox(
        constraints: const BoxConstraints(
            maxHeight: 200,
            minHeight: 100,
            maxWidth: 200,
            minWidth: 100),
        child:
        const Image(image: AssetImage('assets/images/logo.png')));
  }

  Widget _emailSection() {

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'e-mail'),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () => _onPressAuthButton(context, state),
                      child: const Text('인증'))),
            ),
          ],
        );
      },
    );
  }

  void _onPressAuthButton(BuildContext context, AuthState state) {
    BlocProvider.of<AuthBloc>(context).add(SendSignInEmail(state.email));
  }
}
