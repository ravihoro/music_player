import '../models/song.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "songs.db");
    var tempDb = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return tempDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''CREATE TABLE songs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      album TEXT,
      albumId TEXT,
      artist TEXT,
      artistId TEXT,
      year TEXT,
      duration TEXT,
      uri TEXT,
      albumArtwork TEXT,
      isFav INTEGER NOT NULL DEFAULT 0
    )''');
  }

  Future<int> count() async {
    int count = Sqflite.firstIntValue(
        await _database.rawQuery("SELECT COUNT(*) FROM songs"));
    return count;
  }

  Future<void> insertSong(Song song) async {
    await _database.insert("songs", song.toMap());
  }

  Future<List<Song>> fetchSongs() async {
    List<Map> result = await _database.query("songs", orderBy: "title");
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song();
      song = song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchSongsByAlbums() async {
    List<Map> result =
        await _database.query("songs", orderBy: "album", groupBy: "album");
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song();
      song = song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchAlbums() async {
    List<Map> result = await _database.query("songs",
        orderBy: "album", groupBy: "album", distinct: true);
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song();
      song = song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  Future<List<Song>> fetchArtists() async {
    List<Map> result = await _database.query("songs",
        groupBy: "artist", orderBy: "artist", distinct: true);
    List<Song> songs = [];
    result.forEach((s) {
      Song song = Song();
      song = song.fromMap(s);
      songs.add(song);
    });
    return songs;
  }

  // Future<List<Song>> fetchSongsByArtists(int id) async {
  //   List<Map> result = await _database.query("songs", groupBy: "artist");
  //   List<Song> songs = [];
  //   result.forEach((s) {
  //     Song song = Song();
  //     song = song.fromMap(s);
  //     songs.add(song);
  //   });
  //   return songs;
  // }
}
