import 'package:music_player/services/database_helper.dart';
import 'package:music_player/viewmodel/base_model.dart';
import 'package:stacked/stacked.dart';
import '../app/locator.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import '../models/song.dart';

class HomeViewModel extends BaseViewModel {
  DatabaseHelper databaseHelper = locator<DatabaseHelper>();
  FlutterAudioQuery audioQuery = locator<FlutterAudioQuery>();
  BaseModel baseModel = locator<BaseModel>();

  Future fetchSongsFromDatabase() async {
    print("Fetching songs");
    await databaseHelper.database;
    int count = await databaseHelper.count();
    if (count == 0) {
      print("loading from storage");
      await loadDatabase();
    }
    List<Song> songs = await databaseHelper.fetchSongs();
    baseModel.setSongs(songs);
    baseModel.setCurrentSongsList(songs);
    List<Song> albums = await databaseHelper.fetchAlbums();
    baseModel.setAlbums(albums);
    List<Song> artists = await databaseHelper.fetchArtists();
    baseModel.setArtists(artists);
    print("All done");
  }

  Future loadDatabase() async {
    List<SongInfo> songInfoList = await audioQuery.getSongs();
    List<Song> songs = [];
    for (SongInfo songInfo in songInfoList) {
      Song song = Song();
      song = song.fromSongInfo(songInfo);
      songs.add(song);
    }
    for (Song song in songs) {
      await databaseHelper.insertSong(song);
    }
  }
}
