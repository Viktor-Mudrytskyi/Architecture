import 'dart:async';

import 'package:architecture_templates/core/core_src.dart';
import 'package:architecture_templates/di.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// Bootstraps the application with proper initialization sequence.
///
/// Responsibilities:
/// - Flutter bindings initialization
/// - Localization setup
/// - Dependency injection initialization
/// - Logger initialization
/// - Global error handling
abstract class Application {
  /// Runs the complete app initialization and launch sequence.
  ///
  /// Wraps execution in [runZonedGuarded] for global error handling.
  static void run() {
    runZonedGuarded(_initialize, _onUncaughtError);
  }

  static Future<void> _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    await DI().init();

    AppLogger.init();
    AppLogger.i('App started');

    _launchApp();
  }

  static void _onUncaughtError(Object error, StackTrace stack) {
    AppLogger.e('Uncaught error', ex: error, stacktrace: stack);
  }

  static void _launchApp() {
    runApp(
      ResponsiveSizer(
        builder: (_, __, ___) => EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const TemplateApp(),
        ),
      ),
    );
  }
}
