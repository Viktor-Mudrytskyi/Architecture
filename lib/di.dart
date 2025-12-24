import 'package:architecture_templates/core/core_src.dart';
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
class DI extends DIModule {}

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
    // Core Services
    sl.registerLazySingleton<Logger>(
      () => FimberLogger(
        treeType: LogTreeType.custom,
        logFormat: LogFormat.compact,
      ),
    );

    // Set logger instance for static access (backward compatibility)
    AppLogger.setInstance(sl<Logger>());

    // Environment Configuration
    sl.registerSingleton<EnvService>(EnvServiceImpl());
    final config = await sl<EnvService>().loadConfig();
    sl.registerLazySingleton<EnvConfig>(() => config);

    // Routing
    sl.registerLazySingleton<AppRouter>(() => AppRouter());

    // External Dependencies
    sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  }
}
