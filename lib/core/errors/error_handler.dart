import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_exito/core/config/di/di_manager.dart';
import 'package:group_exito/core/models/exceptions/base_exception.dart';
import 'package:group_exito/core/models/exceptions/exceptions.dart';

final class ErrorHandler {
  static bool showAlertOnError = true;

  static FutureOr<void> handleError(FlutterErrorDetails errorDetails) => handleException(errorDetails.exception, stackTrace: errorDetails.stack);

  static FutureOr<void> handleException(
    Object exception, {
    StackTrace? stackTrace,
    bool showAlertOnError = false,
    void Function()? onAlertDismissed,
    String exceptionSource = 'ERROR',
    String? exceptionDescription,
  }) async {
    log(exceptionDescription ?? 'Exception caught by Error Handler', name: exceptionSource, error: exception, stackTrace: stackTrace);
    if (showAlertOnError && exception is! HandledException) {
      if (DIManager.getNavKey().currentContext?.mounted ?? false) {
        String? errorMessage;

        if (exception is BaseException) {
          errorMessage = exception.exceptionMessage;
        } else if (exception is Exception) {
          errorMessage = exception.toString();
        }

        if (errorMessage == null || errorMessage.isEmpty) {
          errorMessage = 'An unexpected error occurred. Please try again later.';
        }
      }

      showDialog<void>(
        context: DIManager.getNavKey().currentContext!,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Error en el Servidor', textAlign: TextAlign.center),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: onAlertDismissed ?? () => DIManager.getNavKey().currentState?.pop(),
                child: const Text('Cerrar', textAlign: TextAlign.center),
              ),
            ],
            content: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('Error details', textAlign: TextAlign.center, maxLines: 10, overflow: TextOverflow.ellipsis),
            ),
          );
        },
      );
    } else {
      log('The error could not be displayed in the UI', name: 'Error HANDLER', error: exception, stackTrace: stackTrace);
    }
  }

  static String getAlertTitleBaseOnException(dynamic exception) {
    return 'Is not you is us';
  }
}
