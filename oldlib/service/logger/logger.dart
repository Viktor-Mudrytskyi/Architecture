abstract interface class AppLogger {
  void logInfo(Object? msg, [StackTrace? stackTrace]);

  void logError(Object? msg, [StackTrace? stackTrace]);
}
