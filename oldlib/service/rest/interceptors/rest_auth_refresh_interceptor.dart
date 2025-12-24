import 'package:architecture_templates/core/exception/exception_handler.dart';
import 'package:dio/dio.dart';

import 'package:architecture_templates/core/extensions.dart';
import '../../../repository/auth/auth_repository.dart';
import '../../../repository/auth/model/refresh_token_request.dart';

class RestAuthRefreshInterceptor extends Interceptor {
  RestAuthRefreshInterceptor({
    required this.authRepository,
    required this.exceptionHandler,
    required this.client,
  });
  final AuthRepository authRepository;
  final Dio client;
  final ExceptionHandler exceptionHandler;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final jwtPair = await authRepository.getJwtPair();
        final newToken = await authRepository.refreshToken(
          RefreshTokenRequest(refreshToken: jwtPair?.refresh ?? ''),
        );
        if (newToken.accessToken.isNotNullOrEmpty) {
          final request = err.requestOptions;
          request.headers['Authorization'] = 'Bearer $newToken';
          final response = await client.fetch(request);
          return handler.resolve(response);
        }
      } catch (e, stackTrace) {
        exceptionHandler.serializeAndLog(e, stackTrace);
        handler.next(err);
        return;
      }
    }
    handler.next(err);
  }
}
