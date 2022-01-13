import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/logic/bloc/top_albums_bloc.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:last_fm_audio_management/models/top_albums.dart';
import 'package:last_fm_audio_management/presentation/pages/custom_widgets/top_album_custom_list_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class TopAlbums extends StatefulWidget {
  const TopAlbums({Key? key, required this.mbId}) : super(key: key);
  final String mbId;
  @override
  _TopAlbumsState createState() => _TopAlbumsState();
}

late ArtistTopAlbums _currentTopAlbumOfArtist;

int _currentPage = 1;     ///to control the current page for pagination

List<Album> _currentAlbumList = [];
final RefreshController refreshController = RefreshController();
bool _isPagination = false;


class _TopAlbumsState extends State<TopAlbums> {


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
      body: _buildTopAlbumsPageBody(),
    );
  }

  Widget _buildTopAlbumsPageBody() {
    final topAlbumsBloc = BlocProvider.of<TopAlbumsBloc>(context);
    topAlbumsBloc.add(FetchTopAlbums(widget.mbId,_currentPage));
    return BlocBuilder<TopAlbumsBloc, TopAlbumsState>(
          /// the part that need to rebuild by bloc state management
            builder: (context, state) {
              if (state is TopAlbumsIsNotSearched) {
                return Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    ' Top Albums of ${widget.mbId}',
                    textDirection: TextDirection.ltr,
                    style: AppTextStyles.screenHeader2TextStyle,
                  ),
                );
              } else if (state is TopAlbumsIsLoading) {
                /// showing Circular Progress indicator while bloc is on isLoading state
                if (!_isPagination)
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
              } else if (state is TopAlbumsIsLoaded) {
                /// while bloc is on isLoaded state and api has responded .
                _currentTopAlbumOfArtist = state.getTopAlbums;
                if (_isPagination) {
                  _currentAlbumList.addAll(_currentTopAlbumOfArtist.topAlbums?.album ?? [],
                  );
                  refreshController.loadComplete();
                  _isPagination = false;
                } else
                  _currentAlbumList = _currentTopAlbumOfArtist.topAlbums?.album ?? [];
                return _currentAlbumList.length > 0
                    ? _buildCustomListView(_currentAlbumList)
                    : Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    ' OOPs , Nothing found ',
                    style: AppTextStyles.screenHeader2TextStyle,
                  ),
                );
              }

              if (_isPagination) {
                return _buildCustomListView(_currentAlbumList);
              } else
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
      String artistName = currentResults[0].artist?.name ?? '' ;


      return Column(
        children: [
          Text(artistName + " Albums ",style: AppTextStyles.screenHeader2TextStyle,),
          Padding(
            padding:
            EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w, bottom: 2.h),
            child: Container(
              height: SizerUtil.orientation == Orientation.portrait ? 75.h : 50.w,
              child: SmartRefresher(
                // pagination  pull to refresh Widget
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: false,
                onLoading: () {
                  // while the user reaches the end of the listView

                  _isPagination = true;
                  _currentPage++;
                  if (_currentPage  <=
                      int.parse(_currentTopAlbumOfArtist.topAlbums!.attr!.totalPages ?? '0',)) {
                    final topAlbumsBloc = BlocProvider.of<TopAlbumsBloc>(context);
                    topAlbumsBloc.add(FetchTopAlbums(widget.mbId,_currentPage));
                  } else
                    refreshController.loadNoData();

                  /// there is no data to display
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final result = currentResults[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, top: 3, bottom: 3),
                        child: TopAlbumsCustomListTile(album:result ,),
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
          ),
        ],
      );
    } catch (e) {
      return Text(
        'OOPs something went wrong ',
        style: AppTextStyles.screenWarningTextStyle,
      );
    }
  }
}
