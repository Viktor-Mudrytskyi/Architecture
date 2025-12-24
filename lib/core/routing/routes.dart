/// Route name constants for GoRouter.
///
/// Using enums provides:
/// - Type safety: Compile-time checking
/// - Refactoring support: IDE can find all usages
/// - No magic strings: Prevents typos
enum RouteNames {
  templates,
  graph,
  nodeInfo,
  mediaDataDetails,
}

/// Route path constants for the application.
///
/// Following SOLID principles:
/// - Single Responsibility: Only defines route paths
/// - Open/Closed: Easy to add new routes without modifying existing code
/// - DRY: Centralized route definitions used throughout the app
abstract class Routes {
  // Templates (Home)
  static const String templates = '/';

  // Graph navigation
  static const String graph = '/graph/:projectId';

  // Node info
  static const String nodeInfo = '/node/:nodeId';

  // Media data details
  static const String mediaDataDetails = '/node/:nodeId/media/:mediaDataId';
}

/// Route parameter keys used in dynamic routes.
abstract class RouteParams {
  static const String projectId = 'projectId';
  static const String nodeId = 'nodeId';
  static const String mediaDataId = 'mediaDataId';
}

/// Extra data keys for passing complex objects via GoRouter extra.
abstract class RouteExtras {
  static const String projectName = 'projectName';
  static const String node = 'node';
  static const String mediaData = 'mediaData';
  static const String mediaDataInteractor = 'mediaDataInteractor';
}
