import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Aduio> loaddata() async {
  final response = await http.get(Uri.parse(
      'http://cast1.asurahosting.com:2199/rpc/ahanghaa/streaminfo.get'));

  if (response.statusCode == 200) {
    return Aduio.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Aduio {
  late String type;
  late List<Data> data;

  Aduio({required this.type, required this.data});

  factory Aduio.fromJson(Map<String, dynamic> json) {
    List list = json['data']  ;
    List<Data> l = list.map((i) => Data.fromJson(i)).toList();
    return Aduio(type: json['type'], data: l);
  }
}

class Data {
  late String title;
  late String song;
  late Track track;
  late String bitrate;
  late String server;
  late String autodj;
  late String source;
  late bool offline;
  late String summary;
  late int listeners;
  late int maxlisteners;
  late int reseller;
  late bool serverstate;
  late bool sourcestate;
  late bool sourceconn;
  late String date;
  late String time;
  late String rawmeta;
  late String mountpoint;
  late String tuneinurl;
  late String tuneinurltls;
  late String directtuneinurl;
  late String proxytuneinurl;
  late String proxytuneinurltls;
  late String tuneinformat;
  late String webplayer;
  late String servertype;
  late int listenertotal;
  late String url;

  Data(
      {required this.title,
      required this.song,
      required this.track,
      required this.bitrate,
      required this.server,
      required this.autodj,
      required this.source,
      required this.offline,
      required this.summary,
      required this.listeners,
      required this.maxlisteners,
      required this.reseller,
      required this.serverstate,
      required this.sourcestate,
      required this.sourceconn,
      required this.date,
      required this.time,
      required this.rawmeta,
      required this.mountpoint,
      required this.tuneinurl,
      required this.tuneinurltls,
      required this.directtuneinurl,
      required this.proxytuneinurl,
      required this.proxytuneinurltls,
      required this.tuneinformat,
      required this.webplayer,
      required this.servertype,
      required this.listenertotal,
      required this.url});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        title: json['title'],
        song: json['song'],
        track: Track.fromJson(json['track']),
        bitrate: json['bitrate'],
        server: json['server'],
        autodj: json['autodj'],
        source: json['source'],
        offline: json['offline'],
        summary: json['summary'],
        listeners: json['listeners'],
        maxlisteners: json['maxlisteners'],
        reseller: json['reseller'],
        serverstate: json['serverstate'],
        sourcestate: json['sourcestate'],
        sourceconn: json['sourceconn'],
        date: json['date'],
        time: json['time'],
        rawmeta: json['rawmeta'],
        mountpoint: json['mountpoint'],
        tuneinurl: json['tuneinurl'],
        tuneinurltls: json['tuneinurltls'],
        directtuneinurl: json['directtuneinurl'],
        proxytuneinurl: json['proxytuneinurl'],
        proxytuneinurltls: json['proxytuneinurltls'],
        tuneinformat: json['tuneinformat'],
        webplayer: json['webplayer'],
        servertype: json['servertype'],
        listenertotal: json['listenertotal'],
        url: json['url']);
  }
}

class Track {
  late String artist;
  late String title;
  late String album;
  late int royaltytrackid;
  late Null started;
  late int id;
  late int length;
  late Playlist playlist;
  late String buyurl;
  late String imageurl;

  Track(
      {required this.artist,
      required this.title,
      required this.album,
      required this.royaltytrackid,
      this.started,
      required this.id,
      required this.length,
      required this.playlist,
      required this.buyurl,
      required this.imageurl});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        artist: json['artist'],
        title: json['title'],
        album: json['album'],
        royaltytrackid: json['royaltytrackid'],
        started: json['started'],
        id: json['id'],
        length: json['length'],
        playlist: Playlist.fromJson(json['playlist']),
        buyurl: json['buyurl'],
        imageurl: json['imageurl']);
  }
}

class Playlist {
  late int id;
  late String title;

  Playlist({required this.id, required this.title});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(id: json['id'], title: json['title']);
  }
}
