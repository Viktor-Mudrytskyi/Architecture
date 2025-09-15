import 'package:architecture_templates/service/http/http_logger.dart';
import 'package:architecture_templates/service/http/http_service.dart';
import 'package:architecture_templates/service/local/secure_storage_service.dart';
import 'package:architecture_templates/service/logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  // getIt.registerFactory(() => L10nConfigs());

  // Managers, services

  // getIt.registerLazySingleton(() => EnvironmentManager(flavor: flavor));

  getIt.registerLazySingleton(() => SecureStorageService());
  getIt.registerLazySingleton(() => Logger());

  // final environmentManager = getIt<EnvironmentManager>();

  // Unauthorised api

  final Dio client = Dio(BaseOptions(baseUrl: ''))
    ..interceptors.add(DioLogger());

  getIt.registerFactory(() => HttpService(client: client));
}
