


class AlbumTracks {
  Album? album;

  AlbumTracks({this.album});

  AlbumTracks.fromJson(Map<String, dynamic> json) {
    album = json['album'] != null ?    Album.fromJson(json['album']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    if (this.album != null) {
      data['album'] = this.album!.toJson();
    }
    return data;
  }
}

class Album {
  String? artist;
  Tags? tags;
  String? name;
  List<Image>? image;
  Tracks? tracks;
  String? listeners;
  String? playcount;
  String? url;
  Wiki? wiki;

  Album(
      {this.artist,
        this.tags,
        this.name,
        this.image,
        this.tracks,
        this.listeners,
        this.playcount,
        this.url,
        this.wiki});

  Album.fromJson(Map<String, dynamic> json) {
    artist = json['artist'];
    tags = json['tags'] != null ?    Tags.fromJson(json['tags']) : null;
    name = json['name'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(   Image.fromJson(v));
      });
    }
    tracks =
    json['tracks'] != null ?    Tracks.fromJson(json['tracks']) : null;
    listeners = json['listeners'];
    playcount = json['playcount'];
    url = json['url'];
    wiki = json['wiki'] != null ?    Wiki.fromJson(json['wiki']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    data['artist'] = this.artist;
    if (this.tags != null) {
      data['tags'] = this.tags!.toJson();
    }
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.toJson();
    }
    data['listeners'] = this.listeners;
    data['playcount'] = this.playcount;
    data['url'] = this.url;
    if (this.wiki != null) {
      data['wiki'] = this.wiki!.toJson();
    }
    return data;
  }
}

class Tags {
  List<Tag>? tag;

  Tags({this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    if (json['tag'] != null) {
      tag = <Tag>[];
      json['tag'].forEach((v) {
        tag!.add(   Tag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    if (this.tag != null) {
      data['tag'] = this.tag!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tag {
  String? url;
  String? name;

  Tag({this.url, this.name});

  Tag.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}

class Image {
  String? size;
  String? text;

  Image({this.size, this.text});

  Image.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    text = json['#text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    data['size'] = this.size;
    data['#text'] = this.text;
    return data;
  }
}

class Tracks {
  List<Track>? track;

  Tracks({this.track});

  Tracks.fromJson(Map<String, dynamic> json) {
    if (json['track'] != null) {
      track = <Track>[];
      json['track'].forEach((v) {
        track!.add(   Track.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    if (this.track != null) {
      data['track'] = this.track!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Track {
  Streamable? streamable;
  int? duration;
  String? url;
  String? name;
  Attr? attr;
  Artist? artist;

  Track(
      {this.streamable,
        this.duration,
        this.url,
        this.name,
        this.attr,
        this.artist});

  Track.fromJson(Map<String, dynamic> json) {
    streamable = json['streamable'] != null
        ?    Streamable.fromJson(json['streamable'])
        : null;
    duration = json['duration'];
    url = json['url'];
    name = json['name'];
    attr = json['@attr'] != null ?    Attr.fromJson(json['@attr']) : null;
    artist =
    json['artist'] != null ?    Artist.fromJson(json['artist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    if (this.streamable != null) {
      data['streamable'] = this.streamable!.toJson();
    }
    data['duration'] = this.duration;
    data['url'] = this.url;
    data['name'] = this.name;
    if (this.attr != null) {
      data['@attr'] = this.attr!.toJson();
    }
    if (this.artist != null) {
      data['artist'] = this.artist!.toJson();
    }
    return data;
  }
}

class Streamable {
  String? fulltrack;
  String? text;

  Streamable({this.fulltrack, this.text});

  Streamable.fromJson(Map<String, dynamic> json) {
    fulltrack = json['fulltrack'];
    text = json['#text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    data['fulltrack'] = this.fulltrack;
    data['#text'] = this.text;
    return data;
  }
}

class Attr {
  int? rank;

  Attr({this.rank});

  Attr.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    data['rank'] = this.rank;
    return data;
  }
}

class Artist {
  String? url;
  String? name;
  String? mbid;

  Artist({this.url, this.name, this.mbid});

  Artist.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    mbid = json['mbid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['mbid'] = this.mbid;
    return data;
  }
}

class Wiki {
  String? published;
  String? summary;
  String? content;

  Wiki({this.published, this.summary, this.content});

  Wiki.fromJson(Map<String, dynamic> json) {
    published = json['published'];
    summary = json['summary'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =    Map<String, dynamic>();
    data['published'] = this.published;
    data['summary'] = this.summary;
    data['content'] = this.content;
    return data;
  }
}