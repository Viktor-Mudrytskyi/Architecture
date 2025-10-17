import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../repository/auth/auth_repository.dart';
import '../repository/auth/auth_repository_impl.dart';
import '../service/env/env_manager.dart';
import '../service/env/flavor.dart';
import '../service/local/secure_storage_service.dart';
import '../service/logger/logger.dart';
import '../service/logger/logger_impl.dart';
import '../service/package_info_service.dart';
import '../service/rest/authorized_rest_service.dart';
import '../service/rest/interceptors/rest_auth_interceptor.dart';
import '../service/rest/interceptors/rest_auth_refresh_interceptor.dart';
import '../service/rest/interceptors/rest_logger_interceptor.dart';
import '../service/rest/public_rest_service.dart';
import 'exception/exception_handler.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI(Flavor flavor) async {
  getIt.registerSingleton(EnvService(flavor: flavor));
  final envConfig = await getIt<EnvService>().getEnvConfig();
  getIt.registerLazySingleton(
    () => ExceptionHandler(logger: getIt<AppLogger>()),
  );
  getIt.registerLazySingleton<AppLogger>(() => AppLoggerImpl());
  getIt.registerLazySingleton<PackageInfoService>(
    () => PackageInfoService(exceptionHandler: getIt()),
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
    () => AuthRepositoryImpl(
      publicRestService: getIt(),
      secureStorageService: getIt(),
      exceptionHandler: getIt(),
    ),
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
