import 'package:cmms_ship_flutter_app/core/domain/entities/node.dart';
import 'package:cmms_ship_flutter_app/core/routing/routes.dart';
import 'package:cmms_ship_flutter_app/features/node_info/domain/entities/media_data.dart';
import 'package:cmms_ship_flutter_app/features/node_info/presentation/interactors/media_data_interactor.dart';
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

  /// Push node info screen onto the navigation stack.
  void pushNodeInfo({required Node node}) {
    final path =
        Routes.nodeInfo.replaceFirst(':${RouteParams.nodeId}', node.id.value);
    push(
      path,
      extra: {
        RouteExtras.node: node,
      },
    );
  }

  /// Push media data details screen onto the navigation stack.
  void pushMediaDataDetails({
    required String nodeId,
    required MediaData mediaData,
    required MediaDataInteractor mediaDataInteractor,
  }) {
    final path = Routes.mediaDataDetails
        .replaceFirst(':${RouteParams.nodeId}', nodeId)
        .replaceFirst(':${RouteParams.mediaDataId}', mediaData.id);
    push(
      path,
      extra: {
        RouteExtras.mediaData: mediaData,
        RouteExtras.mediaDataInteractor: mediaDataInteractor,
      },
    );
  }
}
