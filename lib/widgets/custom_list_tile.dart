import 'package:flutter/material.dart';
import '../models/models.dart';
import '../util/utility.dart';
import 'package:provider/provider.dart';
import '../screens/screens.dart';

class CustomListTile extends StatelessWidget {
  final String page;
  final Song song;
  final bool search;

  CustomListTile(this.song, this.page, [this.search = false]);

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
        page == "songs"
            ? song.title
            : page == "albums"
                ? song.album
                : song.artist,
        style: TextStyle(
          color: Colors.amber,
        ),
      ),
      subtitle: Text(
        page == "songs" ? song.artist : "",
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        page == "songs"
            ? Duration(
                milliseconds: int.parse(song.duration),
              ).toString().substring(2, 7)
            : "",
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        if (search) Navigator.of(context).pop();
        if (page == "songs") {
          final songModel = Provider.of<SongModel>(context, listen: false);
          if (songModel.currentSong != null && song != songModel.currentSong) {
            songModel.stop();
          }
          bool newSong = songModel.currentSong == null
              ? true
              : songModel.currentSong != song;

          if (newSong) {
            songModel.setCurrentSong(song);
          }
          songModel.play(newSong);
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => NowPlaying()));
        }
      },
    );
  }
}
