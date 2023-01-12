import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:way_to_fit/src/presentation/blocs/auth/auth_bloc.dart';

import '../../injector.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

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
          _signInActionsSection(),
          const SizedBox(height: 50),
          _googleSection(),
        ],
      ),
    );
  }

  Widget _logoSection() {
    return ConstrainedBox(
        constraints: const BoxConstraints(
            maxHeight: 200, minHeight: 100, maxWidth: 200, minWidth: 100),
        child: const Image(image: AssetImage('assets/images/logo.png')));
  }

  Widget _signInActionsSection() {
    AuthBloc authBloc = injector.get<AuthBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'e-mail'),
                onChanged: (value) {
                  authBloc.add(EmailChanged(value));
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () => authBloc.add(const SendSignInEmail()),
                      child: const Text('인증'))),
            ),
          ],
        );
      },
    );
  }

  Widget _googleSection() {
    AuthBloc authBloc = injector.get<AuthBloc>();
    // TODO: 2023/01/12 login 성공하면 그 status 를 받아서 메인 페이지로 이동 시켜야함
    
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        width: 200,
        child: IconButton(
          onPressed: () => authBloc.add(const ClickGoogleSignIn()),
          icon: SvgPicture.asset('assets/images/signInWithGoogle.svg'),
        ),
      );
    });
  }
}
