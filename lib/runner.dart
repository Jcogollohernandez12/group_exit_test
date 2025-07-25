import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/core/config/di/di_manager.dart';
import 'package:group_exito/core/config/envs/environments.dart';
import 'package:group_exito/core/config/flavors/flavors.dart';
import 'package:group_exito/core/errors/error_handler.dart';
import 'package:group_exito/ui/app/app.dart';
import 'package:group_exito/ui/app/cubit/theme_cubit.dart';

Future<void> initializeFlutterApp() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Environment().initConfig(env: FlavorConfig.appFlavor);
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        ErrorHandler.handleError(details);
      };

      DIManager.setUpInitialDependencies();

      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        ErrorHandler.handleException(error, stackTrace: stack);
        return true;
      };

      // await _initializeFirebaseApp(FlavorConfig.firebaseAppName, options);

      runApp(BlocProvider<ThemeCubit>(create: (BuildContext context) => ThemeCubit(), child: const App()));
    },
    (Object err, StackTrace stack) {
      ErrorHandler.handleException(err, stackTrace: stack, showAlertOnError: true);
    },
  );
}

// Future<void> _initializeFirebaseApp(
//   String appName,
//   FirebaseOptions? options,
// ) async {
//   try {
//     await Firebase.initializeApp(options: options, name: appName);
//   } catch (err, stack) {
//     ErrorHandler.handleException(err, stackTrace: stack);
//   }
// }
