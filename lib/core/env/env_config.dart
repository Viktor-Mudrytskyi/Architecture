// ═══════════════════════════════════════════════════════════════════════════
// Environment Flavors
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/foundation.dart';

enum Flavor {
  dev,
  prod;

  factory Flavor.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'dev':
        return Flavor.dev;
      case 'prod':
        return Flavor.prod;
      default:
        throw ArgumentError('Unknown flavor: $value');
    }
  }
}

enum LaunchMode {
  debug,
  profile,
  release;

  factory LaunchMode.fromRuntime() {
    if (kDebugMode) {
      return LaunchMode.debug;
    } else if (kProfileMode) {
      return LaunchMode.profile;
    } else if (kReleaseMode) {
      return LaunchMode.release;
    } else {
      throw ArgumentError('Unknown launch mode');
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Env Configuration
// ═══════════════════════════════════════════════════════════════════════════

abstract class EnvConfig {
  /// Current flavor
  Flavor get flavor;

  /// Whether this is a production build.
  ///
  /// Use this for production-only features (analytics, crash reporting).
  bool get isProd => mapFlavor(onDev: () => false, onProd: () => true);

  /// Whether this is a development build.
  bool get isDev => mapFlavor(onDev: () => true, onProd: () => false);

  /// Current launch mode
  LaunchMode get launchMode;

  /// Whether this is a debug build.
  bool get isRelease => mapLaunchMode(
        onDebug: () => false,
        onProfile: () => false,
        onRelease: () => true,
      );

  /// Whether this is a profile build.
  bool get isProfile => mapLaunchMode(
        onDebug: () => false,
        onProfile: () => true,
        onRelease: () => false,
      );

  /// Whether this is a debug build.
  bool get isDebug => mapLaunchMode(
        onDebug: () => true,
        onProfile: () => false,
        onRelease: () => false,
      );

  /// Whether to show the FPS performance overlay.
  ///
  /// Only enabled in `profile` flavor for performance testing.
  bool get showPerformanceOverlay => mapLaunchMode(
        onDebug: () => false,
        onProfile: () => true,
        onRelease: () => false,
      );

  /// Full API URL with protocol.
  String get baseUrl;

  T mapFlavor<T>({required T Function() onDev, required T Function() onProd}) {
    switch (flavor) {
      case Flavor.dev:
        return onDev();
      case Flavor.prod:
        return onProd();
    }
  }

  T mapLaunchMode<T>({
    required T Function() onDebug,
    required T Function() onProfile,
    required T Function() onRelease,
  }) {
    switch (launchMode) {
      case LaunchMode.debug:
        return onDebug();
      case LaunchMode.profile:
        return onProfile();
      case LaunchMode.release:
        return onRelease();
    }
  }
}

class EnvConfigImpl extends EnvConfig {
  EnvConfigImpl({
    required this.flavor,
    required this.launchMode,
    required this.baseUrl,
  });

  @override
  final Flavor flavor;

  @override
  final LaunchMode launchMode;

  @override
  final String baseUrl;
}
