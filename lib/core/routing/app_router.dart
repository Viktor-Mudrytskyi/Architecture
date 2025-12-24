import 'package:architecture_templates/core/core_src.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration using GoRouter.
///
/// Design Patterns Applied:
/// - Factory Pattern: Creates route configurations
/// - Strategy Pattern: Different navigation strategies per route
/// - Singleton Pattern: Single router instance via GetIt
///
/// SOLID Principles:
/// - Single Responsibility: Only handles routing configuration
/// - Open/Closed: New routes added without modifying existing logic
/// - Dependency Inversion: Screens don't depend on router implementation
class AppRouter {
  AppRouter();

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.templates,
    debugLogDiagnostics: true,
    routes: _routes,
  );

  /// Getter for the GoRouter instance.
  GoRouter get router => _router;

  /// Route configuration getter.
  GoRouter get config => _router;

  /// All application routes.
  List<RouteBase> get _routes => [
        // Templates screen (Home)
        // GoRoute(
        //   path: Routes.templates,
        //   name: RouteNames.templates.name,
        //   builder: (context, state) => const TemplatesScreen(),
        // ),

        // // Graph navigation (Graph/List view)
        // GoRoute(
        //   path: Routes.graph,
        //   name: RouteNames.graph.name,
        //   builder: (context, state) {
        //     final projectId = state.pathParameters[RouteParams.projectId]!;
        //     final extra = state.extra as Map<String, dynamic>?;
        //     final projectName =
        //         extra?[RouteExtras.projectName] as String? ?? '';

        //     return GraphListNavigator(
        //       projectId: projectId,
        //       projectName: projectName,
        //     );
        //   },
        // ),

        // // Node info screen
        // GoRoute(
        //   path: Routes.nodeInfo,
        //   name: RouteNames.nodeInfo.name,
        //   builder: (context, state) {
        //     final extra = state.extra as Map<String, dynamic>?;
        //     final node = extra?[RouteExtras.node] as Node?;

        //     if (node == null) {
        //       // Fallback - should not happen in normal flow
        //       return const Scaffold(
        //         body: Center(child: Text('Node not found')),
        //       );
        //     }

        //     return NodeInfoScreen(node: node);
        //   },
        // ),

        // // Media data details screen
        // GoRoute(
        //   path: Routes.mediaDataDetails,
        //   name: RouteNames.mediaDataDetails.name,
        //   builder: (context, state) {
        //     final extra = state.extra as Map<String, dynamic>?;
        //     final mediaData = extra?[RouteExtras.mediaData] as MediaData?;
        //     final mediaDataInteractor =
        //         extra?[RouteExtras.mediaDataInteractor] as MediaDataInteractor?;

        //     if (mediaData == null || mediaDataInteractor == null) {
        //       // Fallback - should not happen in normal flow
        //       return const Scaffold(
        //         body: Center(child: Text('Media data not found')),
        //       );
        //     }

        //     return MediaDataDetailsScreen(
        //       mediaData: mediaData,
        //       mediaDataInteractor: mediaDataInteractor,
        //     );
        //   },
        // ),
      ];
}
