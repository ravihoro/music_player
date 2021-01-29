import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/screens/now_playing.dart';
import 'package:music_player/widgets/custom_bottom_bar.dart';
import 'package:provider/provider.dart';
import '../models/song_model.dart';
import '../util/utility.dart';

class Songs extends StatefulWidget {
  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  FlutterAudioQuery audioQuery;
  Future<List<SongInfo>> songs;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //var model;

  @override
  void initState() {
    super.initState();
    audioQuery = FlutterAudioQuery();
    songs = fetchSongs();
  }

  Future<List<SongInfo>> fetchSongs() async {
    return await audioQuery.getSongs();
  }

  @override
  Widget build(BuildContext context) {
    //var songModel = Provider.of<SongModel>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Songs",
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.amber,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.grey[850],
      body: FutureBuilder<List<SongInfo>>(
        future: songs,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
              ),
            );
          } else {
            var songModel = Provider.of<SongModel>(context, listen: false);
            songModel.setSongs(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return CustomListTile(snapshot.data[index]);
              },
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   child: Icon(
      //     Icons.play_arrow,
      //     size: 35,
      //     color: Colors.amber,
      //   ),
      //   tooltip: 'Now Playing',
      //   onPressed: () {
      //     var songModel = Provider.of<SongModel>(context, listen: false);
      //     if (songModel.currentSong == null) {
      //       final snackbar = SnackBar(
      //           duration: Duration(seconds: 1),
      //           backgroundColor: Colors.black,
      //           content: Text(
      //             'No song selected. Select a song',
      //             style: TextStyle(color: Colors.amber),
      //           ));
      //       _scaffoldKey.currentState.showSnackBar(snackbar);
      //     } else {
      //       Navigator.of(context)
      //           .push(MaterialPageRoute(builder: (context) => NowPlaying()));
      //     }
      //   },
      // ),
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
    );
  }
}

class CustomListTile extends StatelessWidget {
  final SongInfo song;

  CustomListTile(this.song);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: song.albumArtwork == null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.amber),
              ),
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                foregroundColor: Colors.grey[850],
                child: Text(
                  'NA',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            )
          : Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber),
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: FileImage(getImage(song)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
      title: Text(
        song.title,
        style: TextStyle(
          color: Colors.amber,
        ),
      ),
      subtitle: Text(
        song.artist,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        Duration(milliseconds: int.parse(song.duration))
            .toString()
            .substring(2, 7),
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        final songModel = Provider.of<SongModel>(context, listen: false);
        if (songModel.currentSong != null && song != songModel.currentSong) {
          songModel.stop();
        }
        songModel.setCurrentSong(song);
        songModel.play();

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NowPlaying()));
      },
    );
  }
}
