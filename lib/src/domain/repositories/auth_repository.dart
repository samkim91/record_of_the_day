abstract class AuthRepository {

  Future<void> sendSignInEmail(String email);

  Future<void> signInWithGoogle();
}