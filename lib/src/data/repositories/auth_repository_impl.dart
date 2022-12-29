import 'package:firebase_auth/firebase_auth.dart';
import 'package:way_to_fit/src/core/config/logger.dart';
import 'package:way_to_fit/src/domain/repositories/auth_repository.dart';

import '../../core/config/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> sendSignInEmail(String email) async {
    logger.d('sendSignInEmail in repository: $email');

    return await FirebaseAuth.instance
        .sendSignInLinkToEmail(email: email, actionCodeSettings: acs)
        .catchError((onError) => {
              logger.e('auth failed: ${onError.toString()}'),
              Future.error('Login failed')
            });

    // return Future.delayed(const Duration(seconds: 2), () => logger.d('sendSignInEmail in future'));
  }
}
