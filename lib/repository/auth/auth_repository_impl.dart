import 'auth_repository.dart';
import '../../service/local/jwt_pair_model.dart';
import '../../service/rest/public_rest_service.dart';

class AuthRepositoryImpl implements AuthRepository {

  const AuthRepositoryImpl({required PublicRestService publicRestService})
    : _publicRestService = publicRestService;
  final PublicRestService _publicRestService;

  @override
  Future<void> deleteJwtPair() {
    // TODO: implement deleteJwtPair
    throw UnimplementedError();
  }

  @override
  Future<JwtPairModel> getJwtPair() {
    // TODO: implement getJwtPair
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<JwtPairModel> refreshToken() {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> setJwtPair(JwtPairModel jwtPair) {
    // TODO: implement setJwtPair
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String username, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String username, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
