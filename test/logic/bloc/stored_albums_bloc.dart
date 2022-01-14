import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:last_fm_audio_management/logic/bloc/stored_albums_bloc.dart';
import 'package:last_fm_audio_management/models/stored_albums.dart';



void main (){

  group ('StoredAlbumsBloc',(){
    StoredAlbumsBloc artistInfoBloc = StoredAlbumsBloc() ;

    tearDown((){
      artistInfoBloc.close();
    });


    test('The initial value of the StoredAlbumsBloc is StoredAlbumsIsLoaded ', (){
      expect(artistInfoBloc.state, StoredAlbumsIsLoaded(StoredAlbums()));
    });

    blocTest<StoredAlbumsBloc,StoredAlbumsState>(
      ' state should continue in IsLoading and end in IsNotLoaded  in case of error  ',
      build: () => StoredAlbumsBloc(),
      act: (bloc) => bloc.add(FetchStoredAlbums(1)), // malformed arguments is sent to bloc
      wait: const Duration(seconds: 2),
      expect: () => [StoredAlbumsIsLoading(),StoredAlbumsIsNotLoaded() ],
    );


    blocTest<StoredAlbumsBloc,StoredAlbumsState>(
      ' state should continue in IsLoading and end in IsLoaded State ',
      build: () => StoredAlbumsBloc(),
      act: (bloc) => bloc.add(FetchStoredAlbums( 'b8e92589-8b7c-4d0a-9986-02d129997e04')),
      wait: const Duration(seconds: 2),
      expect: () => [StoredAlbumsIsLoading(),isA<StoredAlbumsIsLoaded>() ],
    );


  });

}