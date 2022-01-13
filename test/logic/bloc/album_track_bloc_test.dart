import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:last_fm_audio_management/logic/bloc/album_tracks_bloc.dart';
import 'package:last_fm_audio_management/logic/repository/album_tracks_repo.dart';



void main (){

  group ('AlbumTracksBloc',(){
    AlbumTracksBloc albumTracksBloc = AlbumTracksBloc(AlbumTracksRepo()) ;

    tearDown((){
      albumTracksBloc.close();
    });


    test('The initial value of the AlbumTracksBloc is AlbumTracksIsNotSearched ', (){
      expect(albumTracksBloc.state, AlbumTracksIsNotSearched());
    });



    blocTest<AlbumTracksBloc,AlbumTracksState>(
      ' state should continue in IsLoading and end in IsLoaded State ',
      build: () => AlbumTracksBloc(AlbumTracksRepo()),
      act: (bloc) => bloc.add(FetchAlbumTracks('b8e92589-8b7c-4d0a-9986-02d129997e04')),
      wait: const Duration(seconds: 2),
      expect: () => [AlbumTracksIsLoading(),isA<AlbumTracksIsLoaded>() ],
    );



    blocTest<AlbumTracksBloc,AlbumTracksState>(
      ' state should continue in IsLoading and end in IsNotLoaded  in case of error  ',
      build: () => AlbumTracksBloc(AlbumTracksRepo()),
      act: (bloc) => bloc.add(FetchAlbumTracks(1)), // malformed arguments is sent to bloc
      wait: const Duration(seconds: 2),
      expect: () => [AlbumTracksIsLoading(),AlbumTracksIsNotLoaded() ],
    );

  });

}