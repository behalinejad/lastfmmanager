import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:last_fm_audio_management/core/constants/api_path.dart';
import 'package:last_fm_audio_management/models/artist_info.dart';
import 'package:last_fm_audio_management/models/top_albums.dart';



class TopAlbumsRepo {
  var dio = Dio();

  /// Top Albums Search need both artist mbId and Page for get request

  Future<AlbumTracks> makeArtistTopAlbumsGetRequest(String mbId , int page )  async {
    try {
      late Response<String> response ;
      response = await dio.get(ApiPaths.getArtistTopAlbumsPath(mbId,page));

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