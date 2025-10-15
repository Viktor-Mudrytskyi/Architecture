import 'package:architecture_templates/core/exception/exception_handler.dart';
import 'package:architecture_templates/env/env_manager.dart';
import 'package:architecture_templates/env/flavor.dart';
import 'package:architecture_templates/repository/auth/auth_repository.dart';
import 'package:architecture_templates/repository/auth/auth_repository_impl.dart';
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

Future<void> initDI(Flavor flavor) async {
  getIt.registerSingleton(EnvManager(flavor: flavor));
  final envConfig = await getIt<EnvManager>().getEnvConfig();
  getIt.registerLazySingleton<AppLogger>(() => AppLoggerImpl());
  getIt.registerLazySingleton(
    () => ExceptionHandler(logger: getIt<AppLogger>()),
  );
  getIt.registerLazySingleton(
    () => SecureStorageService(exceptionHandler: getIt()),
  );
  // ---------- Data sources and repositories START ----------
  final Dio publicClient = Dio(BaseOptions(baseUrl: envConfig.baseUrl));
  final loggerInterceptor = RestLoggerInterceptor(logger: getIt<AppLogger>());
  publicClient.interceptors.add(loggerInterceptor);
  getIt.registerLazySingleton<PublicRestService>(
    () => PublicRestService(client: publicClient),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(publicRestService: getIt()),
  );

  final Dio authorizedClient = Dio(BaseOptions(baseUrl: envConfig.baseUrl));
  final restAuthInterceptor = RestAuthInterceptor(
    secureStorageService: getIt<SecureStorageService>(),
  );
  final restAuthRefreshInterceptor = RestAuthRefreshInterceptor(
    authRepository: getIt<AuthRepository>(),
    exceptionHandler: getIt(),
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
