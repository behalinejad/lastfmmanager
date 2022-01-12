import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/logic/repository/album_tracks_repo.dart';
import 'package:last_fm_audio_management/models/album_tracks.dart';



class AlbumTracksEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

/// The Events of Bloc
class FetchAlbumTracks extends AlbumTracksEvent {
  final _mbId ;
  FetchAlbumTracks(this._mbId);

  @override
  List<Object?> get props => [this._mbId];
}

class ResetAlbumTracks extends AlbumTracksEvent {}



class AlbumTracksState extends Equatable {

  @override
  List<Object?> get props => [];
}


/// The States Of bloc
class AlbumTracksIsNotSearched extends AlbumTracksState{}


class AlbumTracksIsLoading extends AlbumTracksState{}


class AlbumTracksIsLoaded extends AlbumTracksState{
  final AlbumTracks  _albumTracks ;
  AlbumTracksIsLoaded(this._albumTracks);


  AlbumTracks get getAlbumTracks => _albumTracks;

  @override
  List<Object?> get props => [this._albumTracks];
}


class AlbumTracksIsNotLoaded extends AlbumTracksState{}


class AlbumTracksBloc extends Bloc<AlbumTracksEvent,AlbumTracksState>{

  AlbumTracksRepo albumTracksRepo ;
  AlbumTracksBloc(this.albumTracksRepo) : super(AlbumTracksIsNotSearched());


  Stream<AlbumTracksState> mapEventToState( AlbumTracksEvent event) async*{
    if (event is FetchAlbumTracks ) {
      yield AlbumTracksIsLoading();

      try{
        AlbumTracks albumTracks = await albumTracksRepo.makeAlbumTracksGetRequest( event._mbId);
        yield AlbumTracksIsLoaded(albumTracks);
      }catch(e){
        yield AlbumTracksIsNotLoaded();
      }
    }else if (event is ResetAlbumTracks){
      yield AlbumTracksIsNotSearched();
    }
  }
}
