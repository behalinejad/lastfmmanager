import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/logic/bloc/artist_info_bloc.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:last_fm_audio_management/models/artist_info.dart';
import 'package:last_fm_audio_management/presentation/pages/custom_widgets/search_page_custom_list_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

late ArtistInfo _currentArtistInfo;

int _currentPage = 1;

///to control the current page for pagination
String _currentSearchStr = '';
List<Artist> _currentResults = [];
final RefreshController refreshController = RefreshController();
bool _isPagination = false;
TextEditingController _searchTextFieldController = TextEditingController();

class _SearchPageState extends State<SearchPage> {
  @override
  void dispose() {
    super.dispose();
  }

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
      body: _buildSearchPageBody(),
    );
  }

  Widget _buildSearchPageBody() {
    final artistInfoBloc = BlocProvider.of<ArtistInfoBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50.w,
              child: TextField(
                controller: _searchTextFieldController,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search Artist'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.sp),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonColor,
                    textStyle: AppTextStyles.screenButtonTextStyle),
                onPressed: () {
                  var searchText = _searchTextFieldController.value.text.trim();
                  if (searchText.length > 0) {
                    _currentPage = 1;
                    _currentResults = [];
                    _currentSearchStr = searchText;
                    artistInfoBloc
                        .add(FetchArtistInfo(_currentPage, searchText));
                  }
                },
                child: SizedBox(
                    height: 6.h,
                    child: Icon(
                      Icons.search,
                      color: Colors.black54,
                    )),
              ),
            ),
          ],
        ),
        BlocBuilder<ArtistInfoBloc, ArtistInfoState>(

            /// the part that need to rebuild by bloc state management
            builder: (context, state) {
          if (state is ArtistInfoIsNotSearched) {
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                'Now it\'s time to Search',
                textDirection: TextDirection.ltr,
                style: AppTextStyles.screenHeader2TextStyle,
              ),
            );
          } else if (state is ArtistInfoIsLoading) {
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
          } else if (state is ArtistInfoIsLoaded) {
            /// while bloc is on isLoaded state and api has responded .
            _currentArtistInfo = state.getArtistInfo;
            if (_isPagination) {
              _currentResults.addAll(
                _currentArtistInfo.results.artistMatches.artist,
              );
              refreshController.loadComplete();
              _isPagination = false;
            } else
              _currentResults = _currentArtistInfo.results.artistMatches.artist;
            return _currentResults.length > 0
                ? _buildCustomListView(_currentResults)
                : Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(
                      ' OOPs , Nothing found ',
                      style: AppTextStyles.screenHeader2TextStyle,
                    ),
                  );
          }

          if (_isPagination) {
            return _buildCustomListView(_currentResults);
          } else
            return Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                ' OOPs , Nothing found ',
                style: AppTextStyles.screenHeader2TextStyle,
              ),
            );

          /// in the case of error or no search result
        }),
      ],
    );
  }

  /// The List view that display Results for Artists
  Widget _buildCustomListView(List<Artist> currentResults) {
    try {
      return Expanded(
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w, bottom: 2.h),
          child: SmartRefresher(
            // pagination  pull to refresh Widget
            controller: refreshController,
            enablePullUp: true,
            enablePullDown: false,
            onLoading: () {
              // while the user reaches the end of the listView

              _isPagination = true;
              _currentPage++;
              if (_currentPage *
                      int.parse(
                          _currentArtistInfo.results.openSearchItemsPerPage) <=
                  int.parse(
                    _currentArtistInfo.results.openSearchTotalResults,
                  )) {
                final artistInfoBloc = BlocProvider.of<ArtistInfoBloc>(context);
                artistInfoBloc
                    .add(FetchArtistInfo(_currentPage, _currentSearchStr));
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
                    child: CustomListTile(
                      artist: result,
                    ),
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
      );
    } catch (e) {
      return Text(
        'OOPs something went wrong ',
        style: AppTextStyles.screenWarningTextStyle,
      );
    }
  }
}
