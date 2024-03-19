import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_theme.dart';

part 'color_theme_state.dart';

class ColorThemeCubit extends Cubit<ColorThemeState> {
  ColorThemeCubit() : super(ColorThemeState.initial());

  void updateAppTheme(){
    final Brightness currentBrightness = AppTheme.currentSystemBrightness;
    currentBrightness == Brightness.light? _setTheme(ThemeMode.light):_setTheme(ThemeMode.dark);
  }

  void _setTheme(ThemeMode themeMode){
    AppTheme.setStatusBarAndNavigationBarColors(themeMode);
    emit(state.copyWith(themeMode: themeMode));
  }

}
