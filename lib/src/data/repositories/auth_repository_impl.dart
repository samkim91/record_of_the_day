import 'package:way_to_fit/src/core/config/logger.dart';
import 'package:way_to_fit/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> sendSignInEmail(String email) {
    logger.d('sendSignInEmail in repository');



    return Future.delayed(const Duration(seconds: 2), () => logger.d('sendSignInEmail in future'));
  }
}
