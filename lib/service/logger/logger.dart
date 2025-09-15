import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  // White text
  void logInfo(Object? msg) {
    if (kDebugMode) {
      log('\x1B[37m${msg.toString()}\x1B[0m');
    }
  }

  // Green text
  void logSuccess(Object? msg) {
    if (kDebugMode) {
      log('\x1B[32m${msg.toString()}\x1B[0m');
    }
  }

  // Yellow text
  void logWarning(Object? msg) {
    if (kDebugMode) {
      log('\x1B[33m${msg.toString()}\x1B[0m');
    }
  }

  // Red text
  void logError(Object? msg) {
    if (kDebugMode) {
      log('\x1B[31m ERROR: ${msg.toString()}\x1B[0m');
    }
  }
}
