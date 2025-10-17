import '../../../core/extensions.dart';
import '../../local/secure_storage_service.dart';
import 'package:dio/dio.dart';

class RestAuthInterceptor extends Interceptor {

  RestAuthInterceptor({required SecureStorageService secureStorageService})
    : _secureStorageService = secureStorageService;
  final SecureStorageService _secureStorageService;

  @override
  Future<void> onRequest(
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
