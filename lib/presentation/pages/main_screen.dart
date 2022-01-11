import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/constants/strings.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:sizer/sizer.dart';




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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                buildThemeIconButton(context),
              ],
            ),
            Center(
              child: Column(
                children: [

                    Padding(
                      padding:   EdgeInsets.symmetric( vertical: 8.h),
                      child: Text(AppStrings.mainScreenTitle,
                        maxLines: 3,
                        style: AppTextStyles.screenHeaderTextStyle,
                      ),
                    ),
                   ClipRRect(
                     borderRadius: BorderRadius.circular(10),
                     child: SizedBox(
                       height: 7.h,
                       width: 50.w,
                       child: Container(
                         color: Theme.of(context).buttonColor,
                         child: Padding(
                           padding:  EdgeInsets.only(left: 5.sp,right: 5.sp),
                           child: TextButton(

                               onPressed: (){
                                 Navigator.of(context).pushNamed('/search_page');
                               },
                               child:  Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Icon(Icons.search_outlined,color: AppTextStyles.screenButtonTextStyle.color,),
                                   Text(AppStrings.mainScreenSearchButtonTitle, // Search Button
                                        style: AppTextStyles.screenButtonTextStyle,

                                   ),
                                   SizedBox(width: 1,),
                                 ],
                               )  ),
                         ),
                       ),
                     ),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  ///Button change the apps theme
  TextButton buildThemeIconButton(BuildContext context) => TextButton(
    onPressed: () =>

    context.read<ThemeCubit>().state.themeMode == ThemeMode.dark ?
    context.read<ThemeCubit>().updateAppTheme(ThemeMode.light  ) :
    context.read<ThemeCubit>().updateAppTheme(ThemeMode.dark  )  ,
    child: Padding(
      padding:  EdgeInsets.only(top: 2.sp),
      child: context.read<ThemeCubit>().state.themeMode == ThemeMode.light ?
      Icon(Icons.nightlight_round,color: Colors.black87) :
      Icon(Icons.wb_sunny,color: Colors.white),
    ),);
}
