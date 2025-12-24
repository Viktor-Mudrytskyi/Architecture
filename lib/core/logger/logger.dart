import 'package:architecture_templates/core/logger/logger_src.dart';
import 'package:fimber/fimber.dart';

/// Log level enumeration for controlling output verbosity.
enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  none,
}

/// Tree type for different logging output formats.
enum LogTreeType {
  /// Standard debug tree with timestamp.
  debug,

  /// Debug tree with elapsed time since app start.
  elapsed,

  /// Custom formatted tree with configurable format.
  custom,

  /// Colorized debug tree (for terminals that support ANSI colors).
  colorized,
}

/// Abstract logging interface (Strategy Pattern).
///
/// Enables swappable backends (Fimber, Crashlytics, etc.) and testability.
abstract class Logger {
  /// Initialize the logger (call once at app startup).
  void init();

  /// Log verbose message (most detailed).
  void v(String message, {dynamic ex, StackTrace? stacktrace});

  /// Log debug message.
  void d(String message, {dynamic ex, StackTrace? stacktrace});

  /// Log info message.
  void i(String message, {dynamic ex, StackTrace? stacktrace});

  /// Log warning message.
  void w(String message, {dynamic ex, StackTrace? stacktrace});

  /// Log error message.
  void e(String message, {dynamic ex, StackTrace? stacktrace});

  /// Execute a block of code with consistent tagging.
  /// Useful for logging multiple related messages.
  T? block<T>(T Function(FimberLog log) block);

  /// Create a tagged logger instance for a specific class/module.
  FimberLog tag(String tag);
}

/// Fimber-based [Logger] implementation.
///
/// ```dart
/// FimberLogger(treeType: LogTreeType.custom, logFormat: LogFormat.compact)
/// ```
class FimberLogger implements Logger {
  FimberLogger({
    this.minLevel = LogLevel.debug,
    this.treeType = LogTreeType.debug,
    this.useColors = false,
    this.logFormat = LogFormat.standard,
    this.customFormatString,
  });

  final LogLevel minLevel;
  final LogTreeType treeType;
  final bool useColors;

  /// Predefined log format from [LogFormat] enum.
  /// Used when [treeType] is [LogTreeType.custom] and
  /// [customFormatString] is not provided.
  final LogFormat logFormat;

  /// Custom format string (overrides [logFormat]).
  /// See [LogFormat] for available tokens.
  final String? customFormatString;

  @override
  void init() {
    final tree = _createTree();
    Fimber.plantTree(tree);
  }

  LogTree _createTree() {
    switch (treeType) {
      case LogTreeType.debug:
        return DebugTree(useColors: useColors);
      case LogTreeType.elapsed:
        return DebugTree.elapsed(useColors: useColors);
      case LogTreeType.custom:
        return CustomFormatTree(
          logFormat: _resolveFormat(),
          useColors: useColors,
        );
      case LogTreeType.colorized:
        return DebugTree(useColors: true);
    }
  }

  /// Resolves the format string to use.
  /// Priority: customFormatString > logFormat
  String _resolveFormat() {
    return customFormatString ?? logFormat.format;
  }

  @override
  void v(String message, {dynamic ex, StackTrace? stacktrace}) {
    if (_shouldLog(LogLevel.verbose)) {
      Fimber.v(message, ex: ex, stacktrace: stacktrace);
    }
  }

  @override
  void d(String message, {dynamic ex, StackTrace? stacktrace}) {
    if (_shouldLog(LogLevel.debug)) {
      Fimber.d(message, ex: ex, stacktrace: stacktrace);
    }
  }

  @override
  void i(String message, {dynamic ex, StackTrace? stacktrace}) {
    if (_shouldLog(LogLevel.info)) {
      Fimber.i(message, ex: ex, stacktrace: stacktrace);
    }
  }

  @override
  void w(String message, {dynamic ex, StackTrace? stacktrace}) {
    if (_shouldLog(LogLevel.warning)) {
      Fimber.w(message, ex: ex, stacktrace: stacktrace);
    }
  }

  @override
  void e(String message, {dynamic ex, StackTrace? stacktrace}) {
    if (_shouldLog(LogLevel.error)) {
      Fimber.e(message, ex: ex, stacktrace: stacktrace);
    }
  }

  @override
  T? block<T>(T Function(FimberLog log) block) {
    return Fimber.block(block) as T?;
  }

  @override
  FimberLog tag(String tag) {
    return FimberLog(tag);
  }

  bool _shouldLog(LogLevel level) => level.index >= minLevel.index;
}

/// Static logging facade delegating to DI-registered [Logger].
///
/// ```dart
/// AppLogger.d('Debug');                    // Basic
/// AppLogger.tag('MyClass').d('Tagged');    // Tagged
/// AppLogger.block((log) => log.d('..'));   // Block
/// ```
class AppLogger {
  static Logger? _instance;

  /// Set the logger instance (called from DI initialization).
  static void setInstance(Logger logger) {
    _instance = logger;
  }

  /// Initialize the logger.
  static void init() {
    _instance?.init();
  }

  /// Log verbose message (most detailed level).
  static void v(String message, {dynamic ex, StackTrace? stacktrace}) {
    _instance?.v(message, ex: ex, stacktrace: stacktrace);
  }

  /// Log debug message.
  static void d(String message, {dynamic ex, StackTrace? stacktrace}) {
    _instance?.d(message, ex: ex, stacktrace: stacktrace);
  }

  /// Log info message.
  static void i(String message, {dynamic ex, StackTrace? stacktrace}) {
    _instance?.i(message, ex: ex, stacktrace: stacktrace);
  }

  /// Log warning message.
  static void w(String message, {dynamic ex, StackTrace? stacktrace}) {
    _instance?.w(message, ex: ex, stacktrace: stacktrace);
  }

  /// Log error message.
  static void e(String message, {dynamic ex, StackTrace? stacktrace}) {
    _instance?.e(message, ex: ex, stacktrace: stacktrace);
  }

  /// Execute a block with auto-tagged logging.
  static T? block<T>(T Function(FimberLog log) block) {
    return _instance?.block(block);
  }

  /// Create a tagged logger for a class/module.
  static FimberLog tag(String tag) {
    return _instance?.tag(tag) ?? FimberLog(tag);
  }
}
