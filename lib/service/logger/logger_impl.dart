import 'dart:io';

import 'logger.dart';
import 'package:logger/logger.dart';

class AppLoggerImpl implements AppLogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(colors: !Platform.isIOS), // Does not work on macOS
  );

  @override
  void logError(Object? msg, [StackTrace? stackTrace]) {
    _logger.e(msg, stackTrace: stackTrace);
  }

  @override
  void logInfo(Object? msg, [StackTrace? stackTrace]) {
    _logger.i(msg, stackTrace: stackTrace);
  }
}
