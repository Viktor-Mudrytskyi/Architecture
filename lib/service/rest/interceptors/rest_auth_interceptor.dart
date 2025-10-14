import 'package:architecture_templates/core/extensions.dart';
import 'package:architecture_templates/service/local/secure_storage_service.dart';
import 'package:dio/dio.dart';

class RestAuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;

  RestAuthInterceptor({required SecureStorageService secureStorageService})
    : _secureStorageService = secureStorageService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokens = await _secureStorageService.getJwtPair();
    if (tokens != null && tokens.access.isNotNullOrEmpty) {
      options.headers['Authorization'] = 'Bearer $tokens';
    }
    handler.next(options);
  }
}
