
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_state.dart';


void main (){

  group ('ThemeCubit',(){
    ThemeCubit themeCubit = ThemeCubit() ;

    tearDown((){
      themeCubit.close();
    });


    test('The initial value of the ThemeCubit is TopAlbumsIsNotSearched ', (){
      expect(themeCubit.state.themeMode,  ThemeState(themeMode: ThemeMode.dark).themeMode);
    });



    blocTest<ThemeCubit,ThemeState>(
      ' Check if cubit state changes after emitting a new state to it  ',
      build: () => ThemeCubit(),
      act: (bloc) => bloc.emit(ThemeState(themeMode: ThemeMode.light)),
      wait: const Duration(seconds: 2),
      expect: () => [ThemeState(themeMode: ThemeMode.light) ],
    );



  });

}