import '../../core/exception/exception_handler.dart';
import '../../service/local/jwt_pair_model.dart';
import '../../service/local/secure_storage_service.dart';
import '../../service/rest/api_method.dart';
import '../../service/rest/public_rest_service.dart';
import 'auth_repository.dart';
import 'model/auth_request.dart';
import 'model/auth_response.dart';
import 'model/refresh_token_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required PublicRestService publicRestService,
    required SecureStorageService secureStorageService,
    required ExceptionHandler exceptionHandler,
  }) : _publicRestService = publicRestService,
       _exceptionHandler = exceptionHandler,
       _secureStorageService = secureStorageService;
  final PublicRestService _publicRestService;
  final SecureStorageService _secureStorageService;
  final ExceptionHandler _exceptionHandler;

  @override
  Future<void> deleteJwtPair() async {
    await _secureStorageService.deleteJwtPair();
  }

  @override
  Future<JwtPairModel?> getJwtPair() {
    return _secureStorageService.getJwtPair();
  }

  @override
  Future<void> logout() {
    return deleteJwtPair();
  }

  @override
  Future<AuthResponse> refreshToken(RefreshTokenRequest request) async {
    try {
      final response = await _publicRestService.request(
        method: ApiMethods.post,
        path: '/auth/refresh-token',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response as Map<String, dynamic>);
    } catch (e, stackTrace) {
      throw _exceptionHandler.handleException(e, stackTrace);
    }
  }

  @override
  Future<void> setJwtPair(JwtPairModel jwtPair) {
    return _secureStorageService.setJwtPair(jwtPair);
  }

  @override
  Future<AuthResponse> signIn(AuthRequest request) async {
    try {
      final response = await _publicRestService.request(
        method: ApiMethods.post,
        path: '/auth/login',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response as Map<String, dynamic>);
    } catch (e, stackTrace) {
      throw _exceptionHandler.handleException(e, stackTrace);
    }
  }

  @override
  Future<AuthResponse> signUp(AuthRequest request) {
    return signIn(request);
  }
}
