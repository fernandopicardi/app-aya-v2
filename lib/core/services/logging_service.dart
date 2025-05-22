import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class LoggingService {
  static final LoggingService _instance = LoggingService._internal();
  factory LoggingService() => _instance;
  LoggingService._internal();

  bool _isDebugMode = kDebugMode;

  void debug(String message) {
    if (_isDebugMode) {
      debugPrint('DEBUG: $message');
    }
  }

  void info(String message) {
    if (_isDebugMode) {
      debugPrint('INFO: $message');
    }
  }

  void warning(String message) {
    if (_isDebugMode) {
      debugPrint('WARNING: $message');
    }
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (_isDebugMode) {
      debugPrint('ERROR: $message');
      if (error != null) {
        debugPrint('Error details: $error');
      }
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  void setDebugMode(bool enabled) {
    _isDebugMode = enabled;
  }
}
