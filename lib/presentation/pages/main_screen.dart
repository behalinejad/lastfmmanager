import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/constants/strings.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            children: [
              TextButton(

                child: Container(
                    color: Colors.white,
                    child: SizedBox(height: 50,width: 50,)),
                onPressed: () =>  context.read<ThemeCubit>().updateAppTheme(ThemeMode.dark)
                ,
              ),
              TextButton(

                child: Container(
                    color: Colors.white,
                    child: SizedBox(height: 50,width: 50,)),
                onPressed: () =>  context.read<ThemeCubit>().updateAppTheme(ThemeMode.light)
                ,
              ),
            ],
          ),
        ),
      ),

    );
  }
}
