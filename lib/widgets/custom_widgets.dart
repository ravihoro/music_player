import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/screens/now_playing.dart';
import 'package:music_player/models/song_model.dart';
import 'package:provider/provider.dart';

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
        songModel.setCurrentSong(song);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NowPlaying()));
      },
    );
  }
}
