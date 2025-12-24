/// Builder for creating custom log formats with Fimber tokens.
///
/// ```dart
/// final format = LogFormatBuilder()
///     ..timestamp()
///     ..separator(' | ')
///     ..level()
///     ..separator(' | ')
///     ..tag()
///     ..separator(': ')
///     ..message();
/// final formatString = format.build();
/// // Result: "{TIME_STAMP} | {LEVEL} | {TAG}: {MESSAGE}"
/// ```
class LogFormatBuilder {
  final StringBuffer _buffer = StringBuffer();

  /// Add timestamp token `{TIME_STAMP}`.
  void timestamp() => _buffer.write(LogToken.timestamp);

  /// Add elapsed time token `{TIME_ELAPSED}`.
  void elapsed() => _buffer.write(LogToken.elapsed);

  /// Add log level token `{LEVEL}`.
  void level() => _buffer.write(LogToken.level);

  /// Add tag token `{TAG}`.
  void tag() => _buffer.write(LogToken.tag);

  /// Add message token `{MESSAGE}`.
  void message() => _buffer.write(LogToken.message);

  /// Add exception message token `{EX_MSG}`.
  void exceptionMessage() => _buffer.write(LogToken.exceptionMessage);

  /// Add exception stacktrace token `{EX_STACK}`.
  void exceptionStack() => _buffer.write(LogToken.exceptionStack);

  /// Add file name token `{FILE_NAME}`.
  void fileName() => _buffer.write(LogToken.fileName);

  /// Add line number token `{LINE_NUMBER}`.
  void lineNumber() => _buffer.write(LogToken.lineNumber);

  /// Add custom separator/text.
  void separator(String sep) => _buffer.write(sep);

  /// Add custom text (alias for [separator]).
  void text(String text) => _buffer.write(text);

  /// Add newline character.
  void newLine() => _buffer.write('\n');

  /// Add tab character.
  void tab() => _buffer.write('\t');

  /// Add level in brackets: `[{LEVEL}]`.
  void levelBracketed() => _buffer.write('[${LogToken.level}]');

  /// Add tag in brackets: `[{TAG}]`.
  void tagBracketed() => _buffer.write('[${LogToken.tag}]');

  /// Add timestamp in brackets: `[{TIME_STAMP}]`.
  void timestampBracketed() => _buffer.write('[${LogToken.timestamp}]');

  /// Add file location: `{FILE_NAME}:{LINE_NUMBER}`.
  void fileLocation() =>
      _buffer.write('${LogToken.fileName}:${LogToken.lineNumber}');

  /// Add file location in parentheses: `({FILE_NAME}:{LINE_NUMBER})`.
  void fileLocationParens() =>
      _buffer.write('(${LogToken.fileName}:${LogToken.lineNumber})');

  /// Build the format string.
  String build() => _buffer.toString();

  /// Reset the builder.
  void reset() => _buffer.clear();

  /// Create format string using builder callback.
  ///
  /// ```dart
  /// final format = LogFormatBuilder.create((b) => b
  ///     ..timestamp()
  ///     ..separator(' ')
  ///     ..levelBracketed()
  ///     ..separator(' ')
  ///     ..tag()
  ///     ..separator(': ')
  ///     ..message());
  /// ```
  static String create(void Function(LogFormatBuilder builder) configure) {
    final builder = LogFormatBuilder();
    configure(builder);
    return builder.build();
  }
}

/// Fimber log format tokens.
abstract class LogToken {
  LogToken._();

  /// Timestamp (e.g., "2024-01-15 10:30:45.123")
  static const String timestamp = '{TIME_STAMP}';

  /// Elapsed time since init (e.g., "+0:00:05.123456")
  static const String elapsed = '{TIME_ELAPSED}';

  /// Log level character (V, D, I, W, E)
  static const String level = '{LEVEL}';

  /// Log tag (class/module name)
  static const String tag = '{TAG}';

  /// Log message
  static const String message = '{MESSAGE}';

  /// Exception message (if provided)
  static const String exceptionMessage = '{EX_MSG}';

  /// Exception stacktrace (if provided)
  static const String exceptionStack = '{EX_STACK}';

  /// Source file name
  static const String fileName = '{FILE_NAME}';

  /// Line number in source file
  static const String lineNumber = '{LINE_NUMBER}';
}
