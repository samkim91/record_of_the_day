import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/presentation/blocs/auth/auth_bloc.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxHeight: 200,
                      minHeight: 100,
                      maxWidth: 200,
                      minWidth: 100),
                  child:
                      const Image(image: AssetImage('assets/images/logo.png'))),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: TextField(
                      maxLines: 1,
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
              ),
            ],
          ),
        );
      },
    );
  }

  void _onPressAuthButton(BuildContext context, AuthState state) {
    BlocProvider.of<AuthBloc>(context).add(SendSignInEmail(state.email));
  }
}
