import 'package:cmms_ship_flutter_app/core/error/failures.dart';
import 'package:cmms_ship_flutter_app/core/logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Standard status enum for cubit operations.
enum BaseStatus {
  /// Initial state before any operation
  initial,

  /// Loading/processing state
  loading,

  /// Operation completed successfully
  success,

  /// Operation failed with error
  error,
}

/// Base cubit class implementing Clean Architecture patterns.
///
/// **Design Patterns Used:**
/// - **Template Method**: Provides skeleton for handling use case results
/// - **Strategy**: Different use cases can be injected for different behaviors
///
/// **SOLID Principles:**
/// - **Single Responsibility**: Cubit only manages state, no business logic
/// - **Open/Closed**: Extended by feature cubits without modification
/// - **Dependency Inversion**: Depends on abstract use cases, not implementations
///
/// **Usage:**
/// ```dart
/// class MyCubit extends BaseCubit<MyState> {
///   MyCubit(this._myUseCase) : super(MyState.initial());
///
///   final MyUseCase _myUseCase;
///
///   Future<void> doSomething(Params params) async {
///     await executeUseCase(
///       useCase: () => _myUseCase(params),
///       onLoading: () => state.copyWith(status: BaseStatus.loading),
///       onSuccess: (data) => state.copyWith(status: BaseStatus.success, data: data),
///       onError: (message) => state.copyWith(status: BaseStatus.error, error: message),
///     );
///   }
/// }
/// ```
abstract class BaseCubit<S> extends Cubit<S> {
  BaseCubit(super.initialState);

  /// Executes a use case and handles the result with appropriate state transitions.
  ///
  /// This method implements the **Template Method Pattern** - it defines the skeleton
  /// of the operation while allowing subclasses to customize state transitions.
  ///
  /// **Parameters:**
  /// - [useCase]: The use case to execute (returns `Either<Failure, T>`)
  /// - [onLoading]: Factory to create loading state
  /// - [onSuccess]: Factory to create success state with data
  /// - [onError]: Factory to create error state with message
  ///
  /// **Flow:**
  /// 1. Emit loading state
  /// 2. Execute use case
  /// 3. Fold result: emit success or error state
  Future<void> executeUseCase<T>({
    required Future<Either<Failure, T>> Function() useCase,
    required S Function() onLoading,
    required S Function(T data) onSuccess,
    required S Function(String message) onError,
  }) async {
    emit(onLoading());

    final result = await useCase();

    result.fold(
      (failure) {
        AppLogger.w('UseCase failed: ${failure.errorMessage}');
        emit(onError(failure.errorMessage));
      },
      (data) => emit(onSuccess(data)),
    );
  }

  /// Executes a use case without emitting loading state.
  ///
  /// Useful for background operations or when loading indicator
  /// is not needed (e.g., silent refresh).
  ///
  /// **Note**: The callbacks should handle emitting states themselves.
  Future<void> executeUseCaseSilent<T>({
    required Future<Either<Failure, T>> Function() useCase,
    required void Function(T data) onSuccess,
    required void Function(String message) onError,
  }) async {
    final result = await useCase();

    result.fold(
      (failure) {
        AppLogger.w('UseCase (silent) failed: ${failure.errorMessage}');
        onError(failure.errorMessage);
      },
      (data) => onSuccess(data),
    );
  }

  /// Executes multiple use cases in sequence.
  ///
  /// Useful for operations that require multiple steps.
  /// Stops execution on first failure.
  Future<void> executeUseCasesSequentially<T>({
    required List<Future<Either<Failure, dynamic>> Function()> useCases,
    required S Function() onLoading,
    required S Function() onSuccess,
    required S Function(String message) onError,
  }) async {
    emit(onLoading());

    for (final useCase in useCases) {
      final result = await useCase();
      if (result.isLeft()) {
        result.fold(
          (failure) {
            AppLogger.w('Sequential UseCase failed: ${failure.errorMessage}');
            emit(onError(failure.errorMessage));
          },
          (_) {},
        );
        return;
      }
    }

    emit(onSuccess());
  }
}
