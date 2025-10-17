import '../../service/local/jwt_pair_model.dart';

abstract interface class AuthRepository {
  Future<JwtPairModel> getJwtPair();
  Future<void> setJwtPair(JwtPairModel jwtPair);
  Future<void> deleteJwtPair();
  Future<void> signIn(String username, String password);
  Future<void> signUp(String username, String password);
  Future<JwtPairModel> refreshToken();
  Future<void> logout();
}
