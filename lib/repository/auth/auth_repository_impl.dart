import 'package:architecture_templates/repository/auth/auth_repository.dart';
import 'package:architecture_templates/service/local/jwt_pair_model.dart';
import 'package:architecture_templates/service/rest/public_rest_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final PublicRestService _publicRestService;

  const AuthRepositoryImpl({required PublicRestService publicRestService})
    : _publicRestService = publicRestService;

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
