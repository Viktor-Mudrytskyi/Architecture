import '../../service/logger/logger.dart';
import 'app_exception.dart';

class ExceptionHandler {
  ExceptionHandler({required AppLogger logger}) : _logger = logger;
  final AppLogger _logger;

  AppException handleException(Object exception, [StackTrace? stackTrace]) {
    _logger.logError(exception, stackTrace);
    return AppException(exception, stackTrace);
  }
}
