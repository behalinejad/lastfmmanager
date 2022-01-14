import 'package:last_fm_audio_management/logic/repository/artist_info_repo.dart';
import 'package:last_fm_audio_management/models/artist_info.dart';
import 'package:test/test.dart';


void main() {
  group('Artist info repository', () {


    test('Sending a test value to the ArtistInfoApi  ', () async {
      ArtistInfoRepo artistInfoRepo = ArtistInfoRepo();
      ArtistInfo artistInfo  = await artistInfoRepo.makeArtistSearchGetRequest('s', 1) ;
      expect(artistInfo.results, isNotNull);
    });




  });
}