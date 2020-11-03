import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/screens/now_playing.dart';
import 'package:provider/provider.dart';
import '../models/song_model.dart';

class Songs extends StatefulWidget {
  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  FlutterAudioQuery audioQuery;
  Future<List<SongInfo>> songs;

  @override
  void initState() {
    super.initState();
    audioQuery = FlutterAudioQuery();
    songs = fetchSongs();
    var songModel = Provider.of<SongModel>(context, listen: false);
    songModel.setSongs(songs);
  }

  Future<List<SongInfo>> fetchSongs() async {
    return await audioQuery.getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return CustomListTile(snapshot.data[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.play_arrow,
            size: 35,
            color: Colors.amber,
          ),
          tooltip: 'Now Playing',
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NowPlaying()));
          }),
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
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.grey[850],
                child: Text('NA'),
              ),
            )
          : Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage(song.albumArtwork),
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
          songModel.setIsPlaying();
          songModel.player.stop();
        }
        songModel.setCurrentSong(song);
        songModel.player.setUrl(songModel.currentSong.uri);
        songModel.player.play();
        songModel.setIsPlaying();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NowPlaying()));
      },
    );
  }
}
