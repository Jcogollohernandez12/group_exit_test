import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:group_exito/ui/feature/home/presentation/pages/categories/categories_page.dart';
import 'package:group_exito/ui/feature/splash/presentation/bloc/splash_bloc.dart';
import 'package:group_exito/ui/feature/splash/presentation/bloc/splash_event.dart';
import 'package:group_exito/ui/feature/splash/presentation/bloc/splash_state.dart';
import 'package:group_exito/ui/feature/splash/presentation/widgets/animations_icon_with_text.dart';
import 'package:group_exito/ui/shared/gradientBackground.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => SplashBloc(),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (BuildContext context, SplashState state) {
          if (state is SplashGoToHome) {
            context.go(CategoriesPage.routeName);
          }
        },
        child: const _SplashView(),
      ),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashBloc>().add(StartSplash());
    });

    return const Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: GradientBackground(child: Center(child: AnimatedIconWithText())),
    );
  }
}
