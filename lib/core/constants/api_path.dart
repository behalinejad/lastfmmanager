class ApiPaths {

  /// The class contains the path related to API



  ///the apiKey is used as authentication ke in LastFm Api

  static final apiKey = '2c072e689f81e83b608116fcac308d7f';


  static String getArtistPath(String artistName){

    return 'https://ws.audioscrobbler.com/2.0/?method=artist.search&artist=$artistName&api_key=$apiKey&format=json' ;
  }


  static String getArtistTopAlbumsPath(String artistName){

    return 'https://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=$artistName&api_key=$apiKey&format=json' ;
  }
}