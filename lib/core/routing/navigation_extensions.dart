import 'package:architecture_templates/core/core_src.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Extension methods for type-safe navigation.
///
/// Design Patterns Applied:
/// - Facade Pattern: Simplifies navigation API
/// - Builder Pattern: Constructs navigation parameters
///
/// Benefits:
/// - Type safety: Compile-time parameter checking
/// - DRY: Reusable navigation methods
/// - KISS: Simple, intuitive API
extension NavigationExtensions on BuildContext {
  /// Navigate to templates screen (home).
  void goToTemplates() {
    go(Routes.templates);
  }

  /// Navigate to graph screen for a project.
  void goToGraph({
    required String projectId,
    required String projectName,
  }) {
    final path =
        Routes.graph.replaceFirst(':${RouteParams.projectId}', projectId);
    go(
      path,
      extra: {
        RouteExtras.projectName: projectName,
      },
    );
  }

  /// Push graph screen onto the navigation stack.
  void pushGraph({
    required String projectId,
    required String projectName,
  }) {
    final path =
        Routes.graph.replaceFirst(':${RouteParams.projectId}', projectId);
    push(
      path,
      extra: {
        RouteExtras.projectName: projectName,
      },
    );
  }
}
