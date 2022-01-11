import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/logic/repository/artist_info_repo.dart';
import 'package:last_fm_audio_management/models/artist_info.dart';

class ArtistInfoEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

/// The Events of Bloc
class FetchArtistInfo extends ArtistInfoEvent {
  final _name ;
  final _page ;
  FetchArtistInfo(this._name, this._page);

  @override
  List<Object?> get props => [this._name,this._page];
}

class ResetArtistInfo extends ArtistInfoEvent {}



class ArtistInfoState extends Equatable {

  @override
  List<Object?> get props => [];
}


/// The States Of bloc
class ArtistInfoIsNotSearched extends ArtistInfoState{}


class ArtistInfoIsLoading extends ArtistInfoState{}


class ArtistInfoIsLoaded extends ArtistInfoState{
  final ArtistInfo  _artistInfo ;
  ArtistInfoIsLoaded(this._artistInfo);


  ArtistInfo get getArtistInfo => _artistInfo;

  @override
  List<Object?> get props => [this._artistInfo];
}


class ArtistInfoIsNotLoaded extends ArtistInfoState{}


class ArtistInfoBloc extends Bloc<ArtistInfoEvent,ArtistInfoState>{

  ArtistInfoRepo artistInfoRepo ;
  ArtistInfoBloc(this.artistInfoRepo) : super(ArtistInfoIsNotSearched());


  Stream<ArtistInfoState> mapEventToState( ArtistInfoEvent event) async*{
    if (event is FetchArtistInfo ) {
      yield ArtistInfoIsLoading();

      try{
        ArtistInfo artistInfo = await artistInfoRepo.makeArtistSearchGetRequest(event._page, event._name);
        yield ArtistInfoIsLoaded(artistInfo);
      }catch(e){
        yield ArtistInfoIsNotLoaded();
      }
    }else if (event is ResetArtistInfo){
      yield ArtistInfoIsNotSearched();
    }
  }
}
