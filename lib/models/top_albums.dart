class ArtistTopAlbums {
  TopAlbums? topAlbums;

  ArtistTopAlbums({ required this.topAlbums});

  ArtistTopAlbums.fromJson(Map<String, dynamic> json) {
    topAlbums = json['topalbums'] != null
        ?  TopAlbums.fromJson(json['topalbums'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.topAlbums != null) {
      data['topalbums'] = this.topAlbums!.toJson();
    }
    return data;
  }
}

class TopAlbums {
  List<Album>? album;
  Attr? attr;

  TopAlbums({this.album, this.attr});

  TopAlbums.fromJson(Map<String, dynamic> json) {
    if (json['album'] != null) {
      album = <Album>[];
      json['album'].forEach((v) {
        album!.add( Album.fromJson(v));
      });
    }
    attr = json['@attr'] != null ?  Attr.fromJson(json['@attr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.album != null) {
      data['album'] = this.album!.map((v) => v.toJson()).toList();
    }
    if (this.attr != null) {
      data['@attr'] = this.attr!.toJson();
    }
    return data;
  }
}

class Album {
  String? name;
  int? playcount;
  String? mbid;
  String? url;
  Artist? artist;
  List<Image>? image;

  Album(
      {this.name,
        this.playcount,
        this.mbid,
        this.url,
        this.artist,
        this.image});

  Album.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    playcount = json['playcount'];
    mbid = json['mbid'];
    url = json['url'];
    artist =
    json['artist'] != null ?   Artist.fromJson(json['artist']) : null;
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(  Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['name'] = this.name;
    data['playcount'] = this.playcount;
    data['mbid'] = this.mbid;
    data['url'] = this.url;
    if (this.artist != null) {
      data['artist'] = this.artist!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artist {
  String? name;
  String? mbid;
  String? url;

  Artist({this.name, this.mbid, this.url});

  Artist.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mbid = json['mbid'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['name'] = this.name;
    data['mbid'] = this.mbid;
    data['url'] = this.url;
    return data;
  }
}

class Image {
  String? text;
  String? size;

  Image({this.text, this.size});

  Image.fromJson(Map<String, dynamic> json) {
    text = json['#text'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['#text'] = this.text;
    data['size'] = this.size;
    return data;
  }
}

class Attr {
  String? artist;
  String? page;
  String? perPage;
  String? totalPages;
  String? total;

  Attr({this.artist, this.page, this.perPage, this.totalPages, this.total});

  Attr.fromJson(Map<String, dynamic> json) {
    artist = json['artist'];
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['artist'] = this.artist;
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['totalPages'] = this.totalPages;
    data['total'] = this.total;
    return data;
  }
}