import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/song_model.dart';
import './models/song.dart';
import './screens/songs.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import './database/database_helper.dart';
import './screens/screens.dart';
import './widgets/custom_bottom_bar.dart';
import './widgets/song_search.dart';

void main() {
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SongModel>(
      create: (context) => SongModel(),
      child: MaterialApp(
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  DatabaseHelper databaseHelper;
  FlutterAudioQuery audioQuery;

  @override
  void initState() {
    super.initState();
    audioQuery = FlutterAudioQuery();
    fetchSongs(context);
  }

  Future fetchSongs(BuildContext context) async {
    databaseHelper = DatabaseHelper();
    await databaseHelper.database;
    int count = await databaseHelper.count();
    //print("Count is: $count");
    if (count == 0) {
      await loadTable();
    }
    List<Song> songs = await databaseHelper.fetchSongs();
    final songModel = Provider.of<SongModel>(context, listen: false);
    //print(songs[0].album);
    songModel.setSongs(songs);

    List<Song> albums = await databaseHelper.fetchAlbums();
    songModel.setAlbums(albums);

    List<Song> artists = await databaseHelper.fetchArtists();
    songModel.setArtists(artists);
  }

  Future loadTable() async {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          centerTitle: true,
          title: Text(
            "Music Player",
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.amber,
              onPressed: () {
                showSearch(context: context, delegate: SongSearch());
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.amber,
            unselectedLabelColor: Colors.amber,
            tabs: [
              Tab(
                child: Text("Songs"),
              ),
              Tab(
                child: Text("Albums"),
              ),
              Tab(
                child: Text("Artists"),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[850],
        body: TabBarView(
          children: [
            Songs(),
            Albums(),
            Artists(),
          ],
        ),
        bottomNavigationBar: Consumer<SongModel>(
          builder: (context, songModel, child) {
            print(songModel.currentSong);
            return songModel.currentSong != null
                ? CustomBottomBar(songModel: songModel)
                : Container(
                    height: 0,
                  );
          },
        ),
      ),
    );
  }
}
