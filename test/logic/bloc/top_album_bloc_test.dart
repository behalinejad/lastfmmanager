import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:last_fm_audio_management/logic/bloc/top_albums_bloc.dart';
import 'package:last_fm_audio_management/logic/repository/top_albums.repo.dart';



void main (){

  group ('TopAlbumsBloc',(){
    TopAlbumsBloc topAlbumsBloc = TopAlbumsBloc(TopAlbumsRepo()) ;

    tearDown((){
      topAlbumsBloc.close();
    });


    test('The initial value of the TopAlbumsBloc is TopAlbumsIsNotSearched ', (){
      expect(topAlbumsBloc.state, TopAlbumsIsNotSearched());
    });



    blocTest<TopAlbumsBloc,TopAlbumsState>(
      ' state should continue in IsLoading and end in IsLoaded State ',
      build: () => TopAlbumsBloc(TopAlbumsRepo()),
      act: (bloc) => bloc.add(FetchTopAlbums( 'b8e92589-8b7c-4d0a-9986-02d129997e04',1)),
      wait: const Duration(seconds: 2),
      expect: () => [TopAlbumsIsLoading(),isA<TopAlbumsIsLoaded>() ],
    );

    blocTest<TopAlbumsBloc,TopAlbumsState>(
      ' state should continue in IsLoading and end in IsNotLoaded  in case of error ',
      build: () => TopAlbumsBloc(TopAlbumsRepo()),
      act: (bloc) => bloc.add(FetchTopAlbums( 1,'b8e92589-8b7c-4d0a-9986-02d129997e04')), // malformed arguments is sent to bloc
      wait: const Duration(seconds: 2),
      expect: () => [TopAlbumsIsLoading(),TopAlbumsIsNotLoaded() ],
    );




  });

}