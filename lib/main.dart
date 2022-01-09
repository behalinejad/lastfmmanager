import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/themes/app_themes.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:last_fm_audio_management/presentation/router/app_router.dart';

void main() {
  runApp(MyApp());
}
final AppRouter _appRouter  = AppRouter();
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit()
        ),
      ],
      child: MusicManagerApp(),
    );
  }

}
class MusicManagerApp extends StatelessWidget {
  const MusicManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: context.select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _appRouter.onGenerateRoute ,
    );
  }
}


