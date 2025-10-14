import 'package:architecture_templates/core/extensions.dart';
import 'package:architecture_templates/repository/auth/auth_repository.dart';
import 'package:dio/dio.dart';

class RestAuthRefreshInterceptor extends Interceptor {
  final AuthRepository authRepository;
  final Dio client;

  RestAuthRefreshInterceptor({
    required this.authRepository,
    required this.client,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await authRepository.refreshToken();
      if (newToken.access.isNotNullOrEmpty) {
        final request = err.requestOptions;
        request.headers['Authorization'] = 'Bearer $newToken';
        final response = await client.fetch(request);
        return handler.resolve(response);
      }
    }
    handler.next(err);
  }
}
