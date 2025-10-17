import 'package:architecture_templates/core/di.dart';
import 'package:architecture_templates/core/exception/app_exception.dart';
import 'package:architecture_templates/main_app.dart';
import 'package:architecture_templates/service/env/flavor.dart';
import 'package:architecture_templates/service/logger/logger.dart';
import 'package:architecture_templates/service/package_info_service.dart';
import 'package:flutter/material.dart';

Future<void> initApp(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    AppException.from(details.exception, details.stack);
  };
  await initDI(flavor);

  final logger = getIt<AppLogger>();
  final packageService = getIt<PackageInfoService>();
  packageService.getPackageInfo().then((value) {
    logger.logInfo(
      'Package Id: ${value?.packageName}, App version(${value?.version}+${value?.buildNumber}), Flavor: ${flavor.name}',
    );
  });

  runApp(MainApp(flavor: flavor));
}
