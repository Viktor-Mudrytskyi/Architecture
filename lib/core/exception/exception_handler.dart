import 'package:architecture_templates/core/exception/app_exception.dart';
import 'package:architecture_templates/service/logger/logger.dart';

class ExceptionHandler {
  final AppLogger _logger;
  ExceptionHandler({required AppLogger logger}) : _logger = logger;

  void handleException(Object exception, [StackTrace? stackTrace]) {
    _logger.logError(exception, stackTrace);
  }

  void handleAndThrowAppException(Object exception, [StackTrace? stackTrace]) {
    handleException(exception, stackTrace);
    throw AppException(exception, stackTrace);
  }
}
