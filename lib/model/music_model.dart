import 'dart:convert';

Song songFromJson(String str) {
  final jsonData = json.decode(str);
  return Song.fromMap(jsonData);
}

String songToJson(Song data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Song {
  String id;
  String title;
  String displayName;
  String filePath;
  String albumArtwork;
  String artist;
  String album;
  String duration;
  String composer;
  bool fav;

  Song({
    this.id,
    this.title,
    this.displayName,
    this.filePath,
    this.albumArtwork,
    this.artist,
    this.album,
    this.duration,
    this.composer,
    this.fav,
  });

  factory Song.fromMap(Map<String, dynamic> json) => new Song(
        id: json["id"],
        title: json["title"],
        displayName: json["display_name"],
        filePath: json["file_path"],
        albumArtwork: json["album_artwork"],
        artist: json["artist"],
        album: json["album"],
        duration: json["duration"],
        composer: json["composer"],
        fav: json["fav"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "display_name": displayName,
        "file_path": filePath,
        "album_artwork": albumArtwork,
        "artist": artist,
        "album": album,
        "duration": duration,
        "composer": composer,
        "fav": fav,
      };
}