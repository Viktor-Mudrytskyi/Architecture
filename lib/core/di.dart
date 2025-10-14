import 'package:architecture_templates/repository/auth/auth_repository.dart';
import 'package:architecture_templates/service/local/secure_storage_service.dart';
import 'package:architecture_templates/service/logger/logger.dart';
import 'package:architecture_templates/service/logger/logger_impl.dart';
import 'package:architecture_templates/service/rest/authorized_rest_service.dart';
import 'package:architecture_templates/service/rest/interceptors/rest_auth_interceptor.dart';
import 'package:architecture_templates/service/rest/interceptors/rest_auth_refresh_interceptor.dart';
import 'package:architecture_templates/service/rest/interceptors/rest_logger_interceptor.dart';
import 'package:architecture_templates/service/rest/public_rest_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  getIt.registerLazySingleton<AppLogger>(() => AppLoggerImpl());
  getIt.registerLazySingleton(
    () => SecureStorageService(logger: getIt<AppLogger>()),
  );
  // ---------- Data sources and repositories START ----------
  final Dio publicClient = Dio(BaseOptions(baseUrl: ''));
  final loggerInterceptor = RestLoggerInterceptor(logger: getIt<AppLogger>());
  publicClient.interceptors.add(loggerInterceptor);
  getIt.registerLazySingleton<PublicRestService>(
    () => PublicRestService(client: publicClient),
  );

  getIt.registerLazySingleton<AuthRepository>(() => getIt());

  final Dio authorizedClient = Dio(BaseOptions(baseUrl: ''));
  final restAuthInterceptor = RestAuthInterceptor(
    secureStorageService: getIt<SecureStorageService>(),
  );
  final restAuthRefreshInterceptor = RestAuthRefreshInterceptor(
    authRepository: getIt<AuthRepository>(),
    client: publicClient,
  );
  authorizedClient.interceptors.addAll([
    loggerInterceptor,
    restAuthInterceptor,
    restAuthRefreshInterceptor,
  ]);

  getIt.registerLazySingleton<AuthorizedRestService>(
    () => AuthorizedRestService(client: authorizedClient),
  );

  // ---------- Data sources and repositories END ----------
}
