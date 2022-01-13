import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:last_fm_audio_management/logic/bloc/artist_info_bloc.dart';
import 'package:last_fm_audio_management/logic/repository/artist_info_repo.dart';




void main (){

  group ('ArtistInfoBloc',(){
    ArtistInfoBloc artistInfoBloc = ArtistInfoBloc(ArtistInfoRepo()) ;

    tearDown((){
      artistInfoBloc.close();
    });


    test('The initial value of the ArtistInfoBloc is ArtistInfoIsNotSearched ', (){
      expect(artistInfoBloc.state, ArtistInfoIsNotSearched());
    });



   blocTest<ArtistInfoBloc,ArtistInfoState>(
      ' state should continue in IsLoading and end in IsLoaded State ',
      build: () => ArtistInfoBloc(ArtistInfoRepo()),
      act: (bloc) => bloc.add(FetchArtistInfo(1, 's')),
      wait: const Duration(seconds: 2),
      expect: () => [ArtistInfoIsLoading(),isA<ArtistInfoIsLoaded>() ],
    );



  blocTest<ArtistInfoBloc,ArtistInfoState>(
    ' state should continue in IsLoading and end in IsNotLoaded  in case of error  ',
    build: () => ArtistInfoBloc(ArtistInfoRepo()),
    act: (bloc) => bloc.add(FetchArtistInfo('s',1)), // malformed arguments is sent to bloc
    wait: const Duration(seconds: 2),
    expect: () => [ArtistInfoIsLoading(),ArtistInfoIsNotLoaded() ],
  );

});

}