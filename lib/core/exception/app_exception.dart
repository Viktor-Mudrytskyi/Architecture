class AppException implements Exception {
  final Object exception;
  final StackTrace? stackTrace;

  AppException(this.exception, [this.stackTrace]);

  static AppException from(Object exception, [StackTrace? stackTrace]) {
    return AppException(exception);
  }

  String get message => exception.toString();
}
