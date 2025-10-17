import 'dart:async';
import 'dart:ui';

import 'package:architecture_templates/core/di.dart';
import 'package:architecture_templates/core/exception/app_exception.dart';
import 'package:architecture_templates/core/exception/exception_handler.dart';
import 'package:architecture_templates/main_app.dart';
import 'package:architecture_templates/service/env/flavor.dart';
import 'package:architecture_templates/service/logger/logger.dart';
import 'package:architecture_templates/service/package_info_service.dart';
import 'package:flutter/material.dart';

void initApp(Flavor flavor) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await initDI(flavor);

      final logger = getIt<AppLogger>();
      final packageService = getIt<PackageInfoService>();
      packageService.getPackageInfo().then((value) {
        logger.logInfo(
          'Package Id: ${value?.packageName}, App version(${value?.version}+${value?.buildNumber}), Flavor: ${flavor.name}',
        );
      });
      final exceptionHandler = getIt<ExceptionHandler>();
      FlutterError.onError = (FlutterErrorDetails details) {
        exceptionHandler.handleException(AppException(details.exception));
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        exceptionHandler.handleException(AppException(error), stack);
        return true;
      };

      runApp(MainApp(flavor: flavor));
    },
    (error, stack) {
      final exceptionHandler = getIt<ExceptionHandler>();
      exceptionHandler.handleException(AppException(error), stack);
    },
  );
}
