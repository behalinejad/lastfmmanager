import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        return MaterialPageRoute(builder: (_) => TopAlbums());

      default :
        return MaterialPageRoute(builder: (_) => MainScreen());

    }

  }
}