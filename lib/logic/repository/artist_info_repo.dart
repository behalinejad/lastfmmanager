import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:last_fm_audio_management/core/constants/api_path.dart';
import 'package:last_fm_audio_management/models/artist_info.dart';



class ArtistInfoRepo {
  var dio = Dio();

  /// Artist Search need both artist and Page for get request

  Future<ArtistInfo> makeArtistSearchGetRequest(String artist , int page )  async {
    try {
      late Response<String> response ;
      response = await dio.get(ApiPaths.getArtistPath(artist,page));

      if ( response.statusCode != 200 )
        throw Exception();
      if(response.data != null ) {
        var jsonResult = json.decode(response.data!) ;
        return ArtistInfo.fromJson(jsonResult);
      }else
        throw Exception();


    } on Exception catch (e) {

      throw e;
    }
  }

}