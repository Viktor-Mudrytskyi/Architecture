/// Log format presets for Fimber [CustomFormatTree].
///
/// **Tokens:** `{TIME_STAMP}`, `{TIME_ELAPSED}`, `{LEVEL}`, `{TAG}`,
/// `{MESSAGE}`, `{EX_MSG}`, `{EX_STACK}`, `{FILE_NAME}`, `{LINE_NUMBER}`
enum LogFormat {
  /// `2024-01-15 10:30:45.123  D  MyClass  Message`
  standard('{TIME_STAMP}\t{LEVEL}\t{TAG}\t{MESSAGE}'),

  /// `[D] MyClass: Message`
  compact('[{LEVEL}] {TAG}: {MESSAGE}'),

  /// `D: Message`
  minimal('{LEVEL}: {MESSAGE}'),

  /// `2024-01-15 10:30:45.123 [D] MyClass (file.dart:42): Message`
  detailed(
    '{TIME_STAMP} [{LEVEL}] {TAG} ({FILE_NAME}:{LINE_NUMBER}): {MESSAGE}',
  ),

  /// `+0:00:05.123 [D] MyClass: Message`
  elapsed('{TIME_ELAPSED} [{LEVEL}] {TAG}: {MESSAGE}'),

  /// `{"time":"...","level":"D","tag":"MyClass","msg":"Message"}`
  json(
    '{{"time":"{TIME_STAMP}","level":"{LEVEL}","tag":"{TAG}","msg":"{MESSAGE}"}}',
  ),

  /// `10:30:45 D/MyClass: Message`
  simple('{TIME_STAMP} {LEVEL}/{TAG}: {MESSAGE}'),

  /// `D/MyClass: Message` (Android style)
  logcat('{LEVEL}/{TAG}: {MESSAGE}'),

  /// `[2024-01-15 10:30:45] [D] [MyClass] Message` (iOS/macOS style)
  console('[{TIME_STAMP}] [{LEVEL}] [{TAG}] {MESSAGE}'),

  /// `2024-01-15 10:30:45.123 | D | MyClass | file.dart:42 | Message`
  full(
    '{TIME_STAMP} | {LEVEL} | {TAG} | {FILE_NAME}:{LINE_NUMBER} | {MESSAGE}',
  ),

  /// `+0:00:05.123 D MyClass@file.dart:42 - Message`
  performance(
    '{TIME_ELAPSED} {LEVEL} {TAG}@{FILE_NAME}:{LINE_NUMBER} - {MESSAGE}',
  ),

  /// `[D] MyClass → Message`
  clean('[{LEVEL}] {TAG} → {MESSAGE}'),

  /// `--- 10:30:45.123 [D] MyClass ---` (multiline)
  boxed('--- {TIME_STAMP} [{LEVEL}] {TAG} ---\n{MESSAGE}'),

  /// `[E] MyClass: Message` + exception info
  exception('[{LEVEL}] {TAG}: {MESSAGE}{EX_MSG}'),

  /// `[E] MyClass: Message` + exception + stacktrace
  exceptionFull('[{LEVEL}] {TAG}: {MESSAGE}\n{EX_MSG}\n{EX_STACK}');

  const LogFormat(this.format);

  /// The format string with Fimber tokens.
  final String format;

  /// Returns the format string.
  @override
  String toString() => format;
}

/// Extension for getting human-readable descriptions.
extension LogFormatDescription on LogFormat {
  /// Human-readable description of the format.
  String get description {
    switch (this) {
      case LogFormat.standard:
        return 'Tab-separated: timestamp, level, tag, message';
      case LogFormat.compact:
        return 'Compact: [level] tag: message';
      case LogFormat.minimal:
        return 'Minimal: level and message only';
      case LogFormat.detailed:
        return 'Detailed with file location';
      case LogFormat.elapsed:
        return 'Elapsed time for performance tracking';
      case LogFormat.json:
        return 'JSON structured format';
      case LogFormat.simple:
        return 'Simple with timestamp';
      case LogFormat.logcat:
        return 'Android logcat style';
      case LogFormat.console:
        return 'iOS/macOS Console style';
      case LogFormat.full:
        return 'Full format with all information';
      case LogFormat.performance:
        return 'Performance-focused with timing';
      case LogFormat.clean:
        return 'Clean readable format';
      case LogFormat.boxed:
        return 'Boxed format with separators';
      case LogFormat.exception:
        return 'Exception-focused format';
      case LogFormat.exceptionFull:
        return 'Full exception with stacktrace';
    }
  }

  /// Example output for the format.
  String get example {
    switch (this) {
      case LogFormat.standard:
        return '2024-01-15 10:30:45.123\tD\tMyClass\tDebug message';
      case LogFormat.compact:
        return '[D] MyClass: Debug message';
      case LogFormat.minimal:
        return 'D: Debug message';
      case LogFormat.detailed:
        return '2024-01-15 10:30:45.123 [D] MyClass (file.dart:42): Debug message';
      case LogFormat.elapsed:
        return '+0:00:05.123 [D] MyClass: Debug message';
      case LogFormat.json:
        return '{"time":"2024-01-15 10:30:45.123","level":"D","tag":"MyClass","msg":"Debug message"}';
      case LogFormat.simple:
        return '10:30:45 D/MyClass: Debug message';
      case LogFormat.logcat:
        return 'D/MyClass: Debug message';
      case LogFormat.console:
        return '[2024-01-15 10:30:45] [DEBUG] [MyClass] Debug message';
      case LogFormat.full:
        return '2024-01-15 10:30:45.123 | D | MyClass | file.dart:42 | Debug message';
      case LogFormat.performance:
        return '+0:00:05.123 D MyClass@file.dart:42 - Debug message';
      case LogFormat.clean:
        return '[DBG] MyClass → Debug message';
      case LogFormat.boxed:
        return '--- 10:30:45.123 [D] MyClass ---\nDebug message';
      case LogFormat.exception:
        return '[E] MyClass: Error | Exception: Something went wrong';
      case LogFormat.exceptionFull:
        return '[E] MyClass: Error\nException message\nStacktrace...';
    }
  }
}
