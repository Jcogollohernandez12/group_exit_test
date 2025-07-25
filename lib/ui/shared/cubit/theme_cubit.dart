import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/core/config/theme/themes.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(Themes.light);

  void setLightTheme() => emit(Themes.light);
  void setDarkTheme() => emit(Themes.dark);

  void toggleTheme() => emit(state.brightness == Brightness.dark ? Themes.light : Themes.dark);
}
