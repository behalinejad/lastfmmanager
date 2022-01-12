import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:last_fm_audio_management/core/constants/api_path.dart';
import 'package:last_fm_audio_management/models/album_tracks.dart';




class AlbumTracksRepo {
  var dio = Dio();

  /// Album tracks needs mbId of the album

  Future<AlbumTracks> makeAlbumTracksGetRequest(String mbId  )  async {
    try {
      late Response<String> response ;
      response = await dio.get(ApiPaths.getAlbumsTrackPath(mbId));

      if ( response.statusCode != 200 )
        throw Exception();
      if(response.data != null ) {
        var jsonResult = json.decode(response.data!) ;
        return AlbumTracks.fromJson(jsonResult);
      }else
        throw Exception();


    } on Exception catch (e) {

      throw e;
    }
  }

}