import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_state.dart';
import 'package:last_fm_audio_management/core/themes/app_themes.dart';


class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.dark)) ;

void updateAppTheme (ThemeMode themeMode){

  AppThemes.setStatusBarAndNavigationBar(themeMode);
  emit(ThemeState(themeMode: themeMode)) ;
}

}