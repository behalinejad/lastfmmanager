
import 'package:flutter/material.dart';
import 'package:last_fm_audio_management/presentation/pages/album_tracks_page.dart';
import 'package:last_fm_audio_management/presentation/pages/main_screen.dart';
import 'package:last_fm_audio_management/presentation/pages/search_page.dart';
import 'package:last_fm_audio_management/presentation/pages/top_albums.dart';

class AppRouter{

  Route onGenerateRoute(RouteSettings routeSettings){


    switch(routeSettings.name) {
      case '/' :
        return MaterialPageRoute(builder: (_) => MainScreen());

      case '/search_page' :
        return MaterialPageRoute(builder: (_) => SearchPage());

      case '/top_albums' :

        return MaterialPageRoute(builder: (_) {
          return TopAlbums(mbId: routeSettings.arguments.toString(),);});

      case '/album_tracks' :

        return MaterialPageRoute(builder: (_) {
          return AlbumTracks(mbId: routeSettings.arguments.toString(),);});
      default :
        return MaterialPageRoute(builder: (_) => MainScreen());

    }

  }
}