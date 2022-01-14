import 'package:last_fm_audio_management/logic/repository/top_albums.repo.dart';
import 'package:last_fm_audio_management/models/top_albums.dart';
import 'package:test/test.dart';


void main() {
  group('Top Albums  repository', () {


    test('Sending a test value to the TopAlbumsApi  ', () async {
      TopAlbumsRepo topAlbumsRepo = TopAlbumsRepo();
      ArtistTopAlbums artistTopAlbums  = await topAlbumsRepo.makeArtistTopAlbumsGetRequest('cc0b7089-c08d-4c10-b6b0-873582c17fd6',1) ;
      expect(artistTopAlbums.topAlbums, isNotNull);
    });




  });
}