import 'package:architecture_templates/core/core_src.dart';
import 'package:equatable/equatable.dart';

/// Base class for all domain-level errors (Failures).
///
/// **Failures vs Exceptions:**
/// - **Exceptions** are thrown in the data layer (network errors, DB errors)
// ignore: unintended_html_in_doc_comment
/// - **Failures** are returned in the domain layer (used with Either<Failure, T>)
///
/// **Why Failures?**
/// Using failures instead of exceptions allows:
/// - Type-safe error handling
/// - No unexpected crashes from uncaught exceptions
/// - Clear error flow through the application
///
/// **Usage with dartz Either:**
/// ```dart
/// Future<Either<Failure, User>> getUser(String id) async {
///   try {
///     final user = await datasource.getUser(id);
///     return Right(user);  // Success
///   } catch (e) {
///     return Left(Failure(errorMessage: 'User not found'));  // Failure
///   }
/// }
///
/// // Handling the result:
/// result.fold(
///   (failure) => showError(failure.errorMessage),
///   (user) => showUser(user),
/// );
/// ```
class Failure extends Equatable {
  const Failure({
    this.errorMessage = 'Unexpected error occurred',
    this.errorCode,
    this.errorData,
  });

  /// Human-readable error message (can be shown to user)
  final String errorMessage;

  /// Additional error details (for debugging)
  final List<ErrorModel>? errorData;

  /// HTTP status code or custom error code
  final int? errorCode;

  @override
  List<Object> get props => [
        errorMessage,
        errorCode ?? 0,
        ...(errorData ?? []),
      ];

  @override
  String toString() {
    return 'Failure(errorMessage: $errorMessage, errorData $errorData, errorCode: $errorCode)';
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Network Failures
// ═══════════════════════════════════════════════════════════════════════════

/// Failure when device has no internet connection.
class InternetConnectionFailure extends Failure {}

// ═══════════════════════════════════════════════════════════════════════════
// Auth Failures
// ═══════════════════════════════════════════════════════════════════════════

/// Failure when user is not authenticated or session expired.
class UnauthorizedFailure extends Failure {}

// ═══════════════════════════════════════════════════════════════════════════
// Image Failures
// ═══════════════════════════════════════════════════════════════════════════

/// Failure when image doesn't meet validation requirements.
class ImageValidationFailure extends Failure {
  const ImageValidationFailure({
    super.errorMessage = 'Image validation failed',
  });
}

/// Failure when image picker operation fails.
class ImagePickerFailure extends Failure {
  const ImagePickerFailure({super.errorMessage = 'Failed to pick image'});
}

/// Failure when package info retrieval fails.
class PackageInfoFailure extends Failure {
  const PackageInfoFailure({super.errorMessage = 'Failed to get package info'});
}
