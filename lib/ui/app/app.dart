import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/core/config/flavors/flavors.dart';
import 'package:group_exito/core/resources/accessibility/accessibility.dart';
import 'package:group_exito/core/router/app_router.dart';
import 'package:group_exito/ui/app/cubit/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (BuildContext context, ThemeData theme) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: FlavorConfig.title,
          theme: theme,
          routerConfig: AppRouter.router,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(data: accessibility.data(context), child: child!);
          },
        );
      },
    );
  }
}
