class AppException implements Exception {

  AppException(this.exception, [this.stackTrace]);
  final Object exception;
  final StackTrace? stackTrace;

  static AppException from(Object exception, [StackTrace? stackTrace]) {
    return AppException(exception);
  }

  String get message => exception.toString();

  @override
  String toString() {
    return message;
  }
}
