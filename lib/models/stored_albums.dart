
///
/// The Model is Used to save and retrieve state of
/// Stored Favorite Albums by user for Hydrated bloc
///

class StoredAlbums {
  List<Album>? albums;
  StoredAlbums({this.albums});



  StoredAlbums.fromJson(Map<String, dynamic> json) {
    if (json['albums'] != null) {
      albums = <Album>[];
      json['albums'].forEach((v) {
        albums!.add( Album.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.albums != null) {
      data['albums'] = this.albums!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Album {
  String? albumName;
  String? albumMbId;
  String? artistName;
  String? artistMbId;
  String? imageUrl;

  Album({this.albumName,
    this.albumMbId,
    this.artistMbId,
    this.artistName,
    this.imageUrl
  });



  Album.fromJson(Map<String, dynamic> json) {
    albumName = json['albumName'];
    albumMbId = json['albumMbId'];
    artistMbId = json['artistMbId'];
    artistName = json['artistName'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['albumName'] = this.albumName;
    data['albumMbId'] = this.albumMbId;
    data['artistMbId'] = this.artistMbId;
    data['artistName'] = this.artistName;
    data['imageUrl'] = this.imageUrl;

    return data;
  }
}

