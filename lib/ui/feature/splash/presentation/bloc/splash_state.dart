import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => <Object>[];
}

class SplashInitial extends SplashState {}

class SplashFinished extends SplashState {}

class SplashGoToHome extends SplashState {}

class SplashGoToLogin extends SplashState {}
