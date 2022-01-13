import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:last_fm_audio_management/models/stored_albums.dart';


class StoredAlbumsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

/// The Events of Bloc
class FetchStoredAlbums extends StoredAlbumsEvent {
  final  _storedAlbums ;
  FetchStoredAlbums(this._storedAlbums);

  @override
  List<Object?> get props => [this._storedAlbums];

}

class ResetStoredAlbums extends StoredAlbumsEvent {}

class StoredAlbumsState extends Equatable {

  @override
  List<Object?> get props => [];
}


/// The States Of bloc
class StoredAlbumsIsNotLoaded extends StoredAlbumsState{}


class StoredAlbumsIsLoading extends StoredAlbumsState{}


class StoredAlbumsIsLoaded extends StoredAlbumsState{
   final  StoredAlbums  _storedAlbums ;
  StoredAlbumsIsLoaded(this._storedAlbums);

  StoredAlbums get getStoredAlbums => _storedAlbums;

  @override
  List<Object?> get props => [this._storedAlbums];


}

class StoredAlbumsBloc extends HydratedBloc<StoredAlbumsEvent,StoredAlbumsState> {
  StoredAlbumsBloc() : super(StoredAlbumsIsLoaded(StoredAlbums()));


  //StoredAlbumsBloc() : super(StoredAlbumsIsNotLoaded())  ;

  @override
  StoredAlbumsState? fromJson(Map<String, dynamic> json) {
    try {
      final storedAlbums = StoredAlbums.fromJson(json);
      return StoredAlbumsIsLoaded(storedAlbums);
    } catch (_) {
       return null ;
    }
  }

  @override
  Map<String, dynamic>? toJson(StoredAlbumsState state) {
    if (state is StoredAlbumsIsLoaded) {
      return state._storedAlbums.toJson();
    }else
      return null ;
  }





Stream<StoredAlbumsState> mapEventToState( StoredAlbumsEvent event) async*{
    if (event is FetchStoredAlbums ) {
      yield StoredAlbumsIsLoading();

      try{
        StoredAlbums storedAlbums = event._storedAlbums;
        yield StoredAlbumsIsLoaded(storedAlbums);
      }catch(e){
        yield StoredAlbumsIsNotLoaded();
      }
    }else if (event is ResetStoredAlbums){
      yield StoredAlbumsIsNotLoaded();
    }
  }

}