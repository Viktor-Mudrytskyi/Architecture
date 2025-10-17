import 'app_exception.dart';
import '../../service/logger/logger.dart';

class ExceptionHandler {
  ExceptionHandler({required AppLogger logger}) : _logger = logger;
  final AppLogger _logger;

  void handleException(Object exception, [StackTrace? stackTrace]) {
    _logger.logError(exception, stackTrace);
  }

  void handleAndThrowAppException(Object exception, [StackTrace? stackTrace]) {
    handleException(exception, stackTrace);
    throw AppException(exception, stackTrace);
  }
}
