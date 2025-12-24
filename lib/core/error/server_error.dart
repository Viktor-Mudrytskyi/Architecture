class ServerError {
  final String? detail;
  final String? message;
  final int? statusCode;

  ServerError({
    this.detail,
    this.message,
    this.statusCode,
  });

  factory ServerError.fromJson(Map<String, dynamic> json) {
    return ServerError(
      detail: json['detail'] as String?,
      message: json['message'] as String?,
      statusCode: json['status_code'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detail': detail,
      'message': message,
      'status_code': statusCode,
    };
  }

  @override
  String toString() {
    return 'ServerError(detail: $detail, message: $message, statusCode: $statusCode)';
  }
}
