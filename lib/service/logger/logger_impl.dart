import 'package:architecture_templates/service/logger/logger.dart';
import 'package:logger/logger.dart';

class AppLoggerImpl implements AppLogger {
  final Logger _logger = Logger(printer: PrettyPrinter());

  @override
  void logError(Object? msg, [StackTrace? stackTrace]) {
    _logger.e(msg, stackTrace: stackTrace);
  }

  @override
  void logInfo(Object? msg, [StackTrace? stackTrace]) {
    _logger.i(msg, stackTrace: stackTrace);
  }
}
