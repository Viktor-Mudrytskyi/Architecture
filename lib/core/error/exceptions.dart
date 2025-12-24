import 'package:architecture_templates/core/core_src.dart';

/// Converts an exception to an appropriate [Failure] type.
///
/// **Purpose:**
/// This function bridges the gap between the data layer (which throws
/// exceptions) and the domain layer (which uses failures).
///
/// **How it works:**
/// 1. Check if it's an HTTP error → return appropriate failure
/// 2. Check internet connection → return [InternetConnectionFailure]
/// 3. Fallback to default failure
///
/// **Error Priority:**
/// 1. HTTP 401/403 → [UnauthorizedFailure]
/// 2. Other HTTP errors → [Failure] with server message
/// 3. No internet → [InternetConnectionFailure]
/// 4. Unknown → [defaultFailure] or generic [Failure]
Future<Failure> errorHandler(Object error, Failure? defaultFailure) async {
  AppLogger.e('Error handler called', ex: error);
  try {
    // Handle HTTP errors from API calls
    if (error is HttpException) {
      AppLogger.w('HTTP error: ${error.statusCode}');

      // Authentication errors
      if (error.statusCode == 403 || error.statusCode == 401) {
        return UnauthorizedFailure();
      }

      // Parse server error message
      final ServerError serverError =
          ServerError.fromJson(error.responseData ?? {});
      return Failure(
        errorMessage: serverError.detail != null &&
                serverError.detail!.isNotEmpty
            ? serverError.detail!
            : 'Sorry, we cannot process your request at the moment. Please contact the support team.',
      );
    }

    // Use provided default failure
    return defaultFailure!;
  } catch (err) {
    AppLogger.e('Error in errorHandler', ex: err);
    return const Failure();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Exception Classes
// ═══════════════════════════════════════════════════════════════════════════

/// Exception thrown when an HTTP request fails.
///
/// **Properties:**
/// - [statusCode]: HTTP status code (e.g., 404, 500)
/// - [responseData]: Parsed JSON response from server
/// - [message]: Optional error message
///
/// **Example:**
/// ```dart
/// throw HttpException(
///   statusCode: 404,
///   message: 'User not found',
/// );
/// ```
class HttpException implements Exception {
  HttpException({
    this.statusCode,
    this.responseData,
    this.message,
  });

  /// HTTP status code (e.g., 200, 404, 500)
  final int? statusCode;

  /// Parsed response body as JSON
  final Map<String, dynamic>? responseData;

  /// Human-readable error message
  final String? message;

  @override
  String toString() =>
      'HttpException(statusCode: $statusCode, message: $message)';
}

/// Generic server exception (database errors, etc.)
class ServerException implements Exception {}
