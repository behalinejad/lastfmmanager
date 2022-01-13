import 'package:last_fm_audio_management/logic/repository/album_tracks_repo.dart';
import 'package:last_fm_audio_management/models/album_tracks.dart';
import 'package:test/test.dart';


void main() {
  group('Albums Track repository', () {


    test('Sending a test value to the AlbumTracksApi  ', () async {
      AlbumTracksRepo albumTracksRepo = AlbumTracksRepo();
      AlbumTracks artistInfo  = await albumTracksRepo.makeAlbumTracksGetRequest('b8e92589-8b7c-4d0a-9986-02d129997e04') ;
      expect(artistInfo.album, isNotNull);
    });




  });
}