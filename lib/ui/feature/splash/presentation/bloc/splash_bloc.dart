import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/ui/feature/splash/presentation/bloc/splash_event.dart';
import 'package:group_exito/ui/feature/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplash>(_onStartSplash);
  }

  Future<void> _onStartSplash(StartSplash event, Emitter<SplashState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 4), () => emit(SplashGoToHome()));
  }
}
