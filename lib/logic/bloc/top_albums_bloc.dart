import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/logic/repository/top_albums.repo.dart';
import 'package:last_fm_audio_management/models/top_albums.dart';

class TopAlbumsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

/// The Events of Bloc
class FetchTopAlbums extends TopAlbumsEvent {
  final _mbId ;
  final _page ;
  FetchTopAlbums(this._mbId, this._page);

  @override
  List<Object?> get props => [this._mbId,this._page];
}

class ResetTopAlbums extends TopAlbumsEvent {}



class TopAlbumsState extends Equatable {

  @override
  List<Object?> get props => [];
}


/// The States Of bloc
class TopAlbumsIsNotSearched extends TopAlbumsState{}

class TopAlbumsIsLoading extends TopAlbumsState{}


class TopAlbumsIsLoaded extends TopAlbumsState{
  final ArtistTopAlbums  _topAlbums ;
  TopAlbumsIsLoaded(this._topAlbums);

  ArtistTopAlbums get getTopAlbums => _topAlbums;

  @override
  List<Object?> get props => [this._topAlbums];
}


class TopAlbumsIsNotLoaded extends TopAlbumsState{}


class TopAlbumsBloc extends Bloc<TopAlbumsEvent,TopAlbumsState>{

  TopAlbumsRepo topAlbumsRepo ;
  TopAlbumsBloc(this.topAlbumsRepo) : super(TopAlbumsIsNotSearched());


  Stream<TopAlbumsState> mapEventToState( TopAlbumsEvent event) async*{
    if (event is FetchTopAlbums ) {
      yield TopAlbumsIsLoading();

      try{
        ArtistTopAlbums topAlbums = await topAlbumsRepo.makeArtistTopAlbumsGetRequest( event._mbId,event._page);
        yield TopAlbumsIsLoaded(topAlbums);
      }catch(e){
        yield TopAlbumsIsNotLoaded();
      }
    }else if (event is ResetTopAlbums){
      yield TopAlbumsIsNotSearched();
    }
  }
}
