import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_player/app/locator.dart';
//import 'package:music_player/view/songs_view.dart';
import 'package:music_player/viewmodel/base_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import './models/song_model.dart';
import './models/song.dart';
import './screens/songs.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import './database/database_helper.dart';
import './screens/screens.dart';
import './widgets/custom_bottom_bar.dart';
import './widgets/song_search.dart';
import 'package:just_audio/just_audio.dart';
import './view/home_view.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DemoApp(),
  );
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
      builder: (context, model, child) {
        return MaterialApp(
          home: HomeView(),
        );
      },
      viewModelBuilder: () => locator<BaseModel>(),
    );
  }
}

class App extends StatelessWidget {
  // final streamController = StreamController();

  // void dispose() {
  //   streamController.close();
  // }

  @override
  Widget build(BuildContext context) {
    Stream<ProcessingState> stream;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SongModel>(
          create: (context) => SongModel(),
        ),
        ChangeNotifierProvider<DatabaseHelper>(
          create: (context) => DatabaseHelper(),
        ),
      ],
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            final songModel = Provider.of<SongModel>(context);
            stream = songModel.player.processingStateStream;
            stream.listen((event) {
              if (event == ProcessingState.completed) {
                songModel.next();
              }
            });
            return MyApp();

            // return StreamBuilder(
            //   stream: songModel.player.processingStateStream,
            //   builder: (context, snapshot) {
            //     if (snapshot.data == ProcessingState.completed) {
            //       songModel.next(false);
            //     }
            //     return MyApp();
            //   },
            // );
          },
        ),
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
    databaseHelper = Provider.of<DatabaseHelper>(context, listen: false);
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

    songModel.setCurrentSongsList(songs);

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
    //final songModel = Provider.of<SongModel>(context);

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
        bottomNavigationBar: CustomBottomBar(),
        // bottomNavigationBar: Consumer<SongModel>(
        //   builder: (context, songModel, child) {
        //     //print(songModel.currentSong);
        //     return songModel.currentSong != null
        //         ? CustomBottomBar()
        //         : Container(
        //             height: 0,
        //           );
        //   },
        // ),
      ),
    );
  }
}
