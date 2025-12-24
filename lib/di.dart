import 'package:cmms_ship_flutter_app/app_config.dart';
import 'package:cmms_ship_flutter_app/core/database/database.dart';
import 'package:cmms_ship_flutter_app/core/domain/services/clock.dart';
import 'package:cmms_ship_flutter_app/core/domain/services/id_generator.dart';
import 'package:cmms_ship_flutter_app/core/logger/logger.dart';
import 'package:cmms_ship_flutter_app/core/network/network_info.dart';
import 'package:cmms_ship_flutter_app/core/routing/app_router.dart';
import 'package:cmms_ship_flutter_app/features/graph/di.dart';
import 'package:cmms_ship_flutter_app/features/image_picker/di.dart';
import 'package:cmms_ship_flutter_app/features/node_info/di.dart';
import 'package:cmms_ship_flutter_app/features/search/di.dart';
import 'package:cmms_ship_flutter_app/features/template/di.dart';
import 'package:cmms_ship_flutter_app/features/user/di.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Service Locator instance for dependency injection.
final sl = GetIt.instance;

/// Main dependency injection container that composes all feature modules.
///
/// Uses the **Composite Pattern** with mixins to combine feature-specific
/// dependency registrations into a single initialization point.
///
/// Usage:
/// ```dart
/// await DI().init();
/// final myService = sl<MyService>();
/// ```
class DI extends DIModule
    with GraphDI, SearchDI, UserDI, TemplateDI, NodeInfoDI, ImagePickerDI {}

/// Base class for dependency injection modules.
///
/// Each feature should create a mixin that extends this class
/// and registers its dependencies in the [init] method.
///
/// Example:
/// ```dart
/// mixin MyFeatureDI on DIModule {
///   @override
///   Future<void> init() async {
///     await super.init();
///     sl.registerFactory<MyRepository>(() => MyRepositoryImpl());
///   }
/// }
/// ```
abstract class DIModule {
  @mustCallSuper
  Future<void> init() async {
    // App Configuration
    sl.registerLazySingleton<AppConfig>(() => AppConfig.init);

    final database = Database();
    sl.registerSingleton<Database>(database);

    // Core Services
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
    sl.registerLazySingleton<IdGenerator>(() => UlidGenerator());
    sl.registerLazySingleton<Clock>(() => SystemClock());
    sl.registerLazySingleton<Logger>(
      () => FimberLogger(
        treeType: LogTreeType.custom,
        logFormat: LogFormat.compact,
      ),
    );

    // Set logger instance for static access (backward compatibility)
    AppLogger.setInstance(sl<Logger>());

    // Routing
    sl.registerLazySingleton<AppRouter>(() => AppRouter());

    // External Dependencies
    sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  }
}
