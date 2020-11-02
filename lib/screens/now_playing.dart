import 'package:flutter/material.dart';
import 'package:music_player/screens/songs.dart';
import '../models/song_model.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Now Playing',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
      body: Container(
        padding: const EdgeInsets.all(10.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Consumer<SongModel>(
          builder: (context, songModel, child) {
            return Text(
              songModel.currentSong.title,
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
