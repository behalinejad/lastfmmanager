import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/constants/strings.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/logic/bloc/album_tracks_bloc.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:last_fm_audio_management/models/album_tracks.dart' as model;
import 'package:sizer/sizer.dart';
import 'custom_widgets/album_tracks_custom_list.dart';



class AlbumTracks extends StatefulWidget {
  const AlbumTracks({Key? key, required this.mbId}) : super(key: key);
  final String mbId;
  @override
  _AlbumTracksState createState() => _AlbumTracksState();
}

late model.AlbumTracks _currentAlbumTracks;
List<model.Track> _albumTrackList = [];


/// This Page shows the list of Tracks in the selected
/// Albums that user has selected in Top Albums page

class _AlbumTracksState extends State<AlbumTracks> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: context.read<ThemeCubit>().state.themeMode == ThemeMode.light
              ? Colors.black54
              : Colors.white, //change your color here
        ),
      ),
      body: _buildAlbumTracksPageBody(),
    );
  }

  Widget _buildAlbumTracksPageBody() {
    final topAlbumsBloc = BlocProvider.of<AlbumTracksBloc>(context);
    topAlbumsBloc.add(FetchAlbumTracks(widget.mbId));
    return BlocBuilder<AlbumTracksBloc, AlbumTracksState>(
      /// the part that need to rebuild by bloc state management
        builder: (context, state) {
          if (state is AlbumTracksIsNotSearched) {
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Center(
                child: Text(
                  ' Not Loaded yet',
                  textDirection: TextDirection.ltr,
                  style: AppTextStyles.screenHeader2TextStyle,
                ),
              ),
            );
          } else if (state is AlbumTracksIsLoading) {
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
                        AppStrings.isLoadingMessage,
                        style: AppTextStyles.screenHeader2TextStyle,
                      )
                    ],
                  ),
                ),
              );
          } else if (state is AlbumTracksIsLoaded) {
            /// while bloc is on isLoaded state and api has responded .
            _currentAlbumTracks = state.getAlbumTracks;
            _albumTrackList =  _currentAlbumTracks.album?.tracks?.track ?? []  ;
            return _albumTrackList.length > 0
                ? _buildCustomListView(_albumTrackList,_currentAlbumTracks)
                : Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Center(
                child: Text(
                  AppStrings.nothingFoundMessage,
                  style: AppTextStyles.screenHeader2TextStyle,
                ),
              ),
            );
          }


            return Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Center(
                child: Text(
                  AppStrings.nothingFoundMessage,
                  style: AppTextStyles.screenHeader2TextStyle,
                ),
              ),
            );

          /// in the case of error or no search result
        });

  }

  /// The List view that display Results for Tracks
  Widget _buildCustomListView(List<model.Track> currentResults, model.AlbumTracks currentAlbumTracks) {
    try {
      String _albumName = currentAlbumTracks.album?.name ?? '' ;
      String imageUrl = '';
      if (currentAlbumTracks.album?.image![3] != null)    ///Using the large format of the image in case of existence
        imageUrl = currentAlbumTracks.album?.image![3].text ?? '' ;


      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(bottom: 3.sp),
              child: Text( _albumName,style: AppTextStyles.screenHeader2TextStyle,),
            ),
            imageUrl != '' ? Container(
              height: SizerUtil.orientation == Orientation.portrait ? 40.h :50.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(imageUrl ,fit: BoxFit.fill,errorBuilder: (_,__,___){
                  return Container();
                } ),
              ),
            )  : Container(),
            Padding(
              padding:  EdgeInsets.only(top: 5.sp,left: 20.w,right: 20.w),
              child: Divider(thickness: 2,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.h, left: 5.w, right: 5.w, bottom: 10.h),
              child: Container(
                height: SizerUtil.orientation == Orientation.portrait ? 75.h : 50.w,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final result = currentResults[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, top: 3, bottom: 3),
                        child: AlbumTracksCustomListTile(track:result ,albumTracks: _currentAlbumTracks,),
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: currentResults.length),
              ),

            ),

          ],
        ),
      );
    } catch (e) {
      return Center(
        child: Text(
          AppStrings.nothingFoundMessage,
          style: AppTextStyles.screenWarningTextStyle,
        ),
      );
    }
  }
}
