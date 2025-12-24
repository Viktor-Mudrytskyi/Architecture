import 'dart:async';
import 'dart:ui';

import 'package:architecture_templates/core/di.dart';
import 'package:architecture_templates/core/exception/app_exception.dart';
import 'package:architecture_templates/core/exception/exception_handler.dart';
import 'package:flutter/material.dart';

import 'main_app.dart';
import 'service/env/flavor.dart';
import 'service/logger/logger.dart';
import 'service/package_info_service.dart';

void initApp(Flavor flavor) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await initDI(flavor);

      final logger = getIt<AppLogger>();

      final packageService = getIt<PackageInfoService>();
      unawaited(
        packageService.getPackageInfo().then((value) {
          logger.logInfo(
            'Package Id: ${value?.packageName}, App version(${value?.version}+${value?.buildNumber}), Flavor: ${flavor.name}',
          );
        }),
      );
      final exceptionHandler = getIt<ExceptionHandler>();
      FlutterError.onError = (FlutterErrorDetails details) {
        exceptionHandler.serializeAndLog(AppException(details.exception));
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        exceptionHandler.serializeAndLog(AppException(error), stack);
        return true;
      };

      runApp(MainApp(flavor: flavor));
    },
    (error, stack) {
      final exceptionHandler = getIt<ExceptionHandler>();
      exceptionHandler.serializeAndLog(AppException(error), stack);
    },
  );
}
