
import 'dart:convert';

/*ArtistInfo artistInfoFromJson(String str) => ArtistInfo.fromJson(json.decode(str));

String artistInfoToJson(ArtistInfo data) => json.encode(data.toJson());*/

class ArtistInfo {
  ArtistInfo({
       required this.results,
  });

  Results results;

  factory ArtistInfo.fromJson(Map<String, dynamic> json) => ArtistInfo(
    results: Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
  };
}

class Results {
  Results({
    required this.openSearchQuery,
    required this.openSearchTotalResults,
    required this.openSearchStartIndex,
    required this.openSearchItemsPerPage,
    required this.artistMatches,
    required this.attr,
  });

  OpenSearchQuery openSearchQuery;
  String openSearchTotalResults;
  String openSearchStartIndex;
  String openSearchItemsPerPage;
  ArtistMatches artistMatches;
  Attr attr;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    openSearchQuery: OpenSearchQuery.fromJson(json["opensearch:Query"]),
    openSearchTotalResults: json["opensearch:totalResults"],
    openSearchStartIndex: json["opensearch:startIndex"],
    openSearchItemsPerPage: json["opensearch:itemsPerPage"],
    artistMatches: ArtistMatches.fromJson(json["artistmatches"]),
    attr: Attr.fromJson(json["@attr"]),
  );

  Map<String, dynamic> toJson() => {
    "opensearch:Query": openSearchQuery.toJson(),
    "opensearch:totalResults": openSearchTotalResults,
    "opensearch:startIndex": openSearchStartIndex,
    "opensearch:itemsPerPage": openSearchItemsPerPage,
    "artistmatches": artistMatches.toJson(),
    "@attr": attr.toJson(),
  };
}

class ArtistMatches {
  ArtistMatches({
    required this.artist,
  });

  List<Artist> artist;

  factory ArtistMatches.fromJson(Map<String, dynamic> json) => ArtistMatches(
    artist: List<Artist>.from(json["artist"].map((x) => Artist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "artist": List<dynamic>.from(artist.map((x) => x.toJson())),
  };
}

class Artist {
  Artist({
    required this.name,
    required this.listeners,
    required this.mbid,
    required this.url,
    required this.streamable,
    required this.image,
  });

  String name;
  String listeners;
  String mbid;
  String url;
  String streamable;
  List<Image> image;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    name: json["name"],
    listeners: json["listeners"],
    mbid: json["mbid"],
    url: json["url"],
    streamable: json["streamable"],
    image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "listeners": listeners,
    "mbid": mbid,
    "url": url,
    "streamable": streamable,

  };
}

class Image {
  Image({
    required this.text,
    required this.size,
  });

  String text;
  Size size;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    text: json["#text"],
    size: sizeValues.map[json["size"]]! ,
  );


}

enum Size { SMALL, MEDIUM, LARGE, EXTRALARGE, MEGA }

final sizeValues = EnumValues({
  "extralarge": Size.EXTRALARGE,
  "large": Size.LARGE,
  "medium": Size.MEDIUM,
  "mega": Size.MEGA,
  "small": Size.SMALL
});

class Attr {
  Attr({
    required this.attrFor,
  });

  String attrFor;

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
    attrFor: json["for"],
  );

  Map<String, dynamic> toJson() => {
    "for": attrFor,
  };
}

class OpenSearchQuery {
  OpenSearchQuery({
    required this.text,
    required this.role,
    required this.searchTerms,
    required this.startPage,
  });

  String text;
  String role;
  String searchTerms;
  String startPage;

  factory OpenSearchQuery.fromJson(Map<String, dynamic> json) => OpenSearchQuery(
    text: json["#text"],
    role: json["role"],
    searchTerms: json["searchTerms"],
    startPage: json["startPage"],
  );

  Map<String, dynamic> toJson() => {
    "#text": text,
    "role": role,
    "searchTerms": searchTerms,
    "startPage": startPage,
  };
}

class EnumValues<T> {
   Map<String, T> map;
  EnumValues(this.map);


}
