import 'dart:developer' as developer;

import 'package:group_exito/core/models/exceptions/base_exception.dart';

class Logger {
  static void log(String message) {
    _printWithColor('[LOG] $message', _AnsiColors.green);
  }

  static void error(String message, {String? name}) {
    _printWithColor('[ERROR ${name != null ? '($name)' : ''}] $message', _AnsiColors.red);
  }

  static void warning(String message) {
    _printWithColor('[WARNING] $message', _AnsiColors.yellow);
  }

  static void _printWithColor(String message, String colorCode) {
    developer.log('$colorCode$message${_AnsiColors.reset}');
  }
}

class _AnsiColors {
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
}

class GenericException extends BaseException {
  static const String name = 'GenericException';

  GenericException(super.message, {super.stackTrace}) {
    Logger.error(message ?? 'GenericException', name: name);
  }

  @override
  String get exceptionMessage {
    Logger.error(message ?? 'GenericException', name: name);
    return message ?? 'AppLocalizations.fromInstance().genericException';
  }
}

class HandledException extends BaseException {
  static const String name = 'HandledException';

  HandledException(super.message, {super.stackTrace}) {
    Logger.warning(message ?? 'HandledException');
  }

  @override
  String get exceptionMessage {
    Logger.warning(message ?? 'HandledException');
    return message ?? 'AppLocalizations.fromInstance().genericException';
  }
}
