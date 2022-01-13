import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/constants/strings.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/logic/bloc/stored_albums_bloc.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:last_fm_audio_management/models/stored_albums.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import 'custom_widgets/stored_album_list_tile.dart';



/// The first loading Screen of the app
/// that shows the Stored Albums in the list
/// and also can Navigate the user to the Search Page of Artists



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

late StoredAlbums _currentStoredAlbums;
List<Album> _storedAlbumsList = [];
final RefreshController refreshController = RefreshController();




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
                      padding:   EdgeInsets.only( bottom: 5.h,top: SizerUtil.orientation == Orientation.portrait ? 5.h : 1.w,),
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
                               key: Key('searchArtistButton'),
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
                  _buildSortedAlbumsPageBody(),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  ///A Button that changes the apps theme
  TextButton buildThemeIconButton(BuildContext context) => TextButton(
    onPressed: () =>

    context.read<ThemeCubit>().state.themeMode == ThemeMode.dark ?
    context.read<ThemeCubit>().updateAppTheme(ThemeMode.light  ) :
    context.read<ThemeCubit>().updateAppTheme(ThemeMode.dark  )  ,
    child: Padding(
      padding:  EdgeInsets.only(top: 15.sp),
      child: context.read<ThemeCubit>().state.themeMode == ThemeMode.light ?
      Icon(Icons.nightlight_round,color: Colors.black87) :
      Icon(Icons.wb_sunny,color: Colors.white),
    ),);


  Widget _buildSortedAlbumsPageBody() {

    return BlocBuilder<StoredAlbumsBloc, StoredAlbumsState>(
      /// the part that need to rebuild by bloc state management
        builder: (context, state) {
          if (state is StoredAlbumsIsNotLoaded) {
            return Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                ' No Album is in the Favorite List.  ',
                style: AppTextStyles.screenHeader2TextStyle,
              ),
            );
          } else if (state is StoredAlbumsIsLoading) {
            /// showing Circular Progress indicator while bloc is on isLoading state

              return Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        ' Loading ...',
                        style: AppTextStyles.screenHeader2TextStyle,
                      )
                    ],
                  ),
                ),
              );
          }  if (state is StoredAlbumsIsLoaded) {
            /// while bloc is on isLoaded state and api has responded .
            _currentStoredAlbums = state.getStoredAlbums;

              _storedAlbumsList = _currentStoredAlbums.albums ?? [];
            return _storedAlbumsList.length > 0
                ? _buildCustomListView(_storedAlbumsList)
                : Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                ' No Album is in the Favorite List  ',
                style: AppTextStyles.screenHeader2TextStyle,
              ),
            );
          }

            return Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                ' OOPs , Nothing found ',
                style: AppTextStyles.screenHeader2TextStyle,
              ),
            );

          /// in the case of error or no search result
        });

  }

  /// The List view that display Results for Albums
  Widget _buildCustomListView(List<Album> currentResults) {
    try {

      return Padding(
        padding:
        EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w, bottom: 2.h),
        child: Container(
          height: SizerUtil.orientation == Orientation.portrait ? 65.h : 35.w, // To control the size of the List in case of orientation .
          child: ListView.separated(

                itemBuilder: (context, index) {
                final result = currentResults[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 16, top: 3, bottom: 3),
                  child: StoredAlbumsCustomListTile(album:result ,),
                );
              },
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              separatorBuilder: (_, index) => SizedBox(
                height: 5,
              ),
              itemCount: currentResults.length),
        ),
      );
    } catch (e) {
      return Text(
        'OOPs something went wrong ',
        style: AppTextStyles.screenWarningTextStyle,
      );
    }
  }


}
