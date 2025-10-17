import '../../service/local/jwt_pair_model.dart';
import 'model/auth_request.dart';
import 'model/auth_response.dart';
import 'model/refresh_token_request.dart';

abstract interface class AuthRepository {
  Future<JwtPairModel?> getJwtPair();
  Future<void> setJwtPair(JwtPairModel jwtPair);
  Future<void> deleteJwtPair();
  Future<AuthResponse> signIn(AuthRequest request);
  Future<AuthResponse> signUp(AuthRequest request);
  Future<void> logout();
  Future<AuthResponse> refreshToken(RefreshTokenRequest request);
}
