import 'package:flutter/material.dart';
import 'package:music_player/database/database_helper.dart';
import 'package:music_player/screens/album_details.dart';
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
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: song.albumArtwork != null
                ? FileImage(getImage(song))
                : AssetImage("assets/images/music.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        page == "songs" ||
                page == "albumDetail" ||
                page == "artistDetail" ||
                page == "nowPlaying"
            ? song.title
            : page == "albums"
                ? song.album
                : song.artist,
        style: TextStyle(
          color: Colors.amber,
        ),
      ),
      subtitle: Text(
        page == "songs" ||
                page == "albumDetail" ||
                page == "albums" ||
                page == "nowPlaying"
            ? song.artist
            : song.album,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        page == "songs" || page == "albumDetail" || page == "nowPlaying"
            ? Duration(
                milliseconds: int.parse(song.duration),
              ).toString().substring(2, 7)
            : "",
        style: TextStyle(color: Colors.white),
      ),
      onTap: () async {
        if (search) Navigator.of(context).pop();
        if (page == "songs") {
          final songModel = Provider.of<SongModel>(context, listen: false);
          if (songModel.songs != songModel.currentSongsList) {
            songModel.setCurrentSongsList(songModel.songs);
          }
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
        } else if (page == "albums") {
          final songModel = Provider.of<SongModel>(context, listen: false);
          final databaseHelper =
              Provider.of<DatabaseHelper>(context, listen: false);
          List<Song> album = await databaseHelper.fetchAlbumById(song.albumId);
          songModel.setAlbum(album);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AlbumDetails()));
        } else if (page == "albumDetail") {
          final songModel = Provider.of<SongModel>(context, listen: false);

          if (songModel.currentAlbum != songModel.currentSongsList) {
            songModel.setCurrentSongsList(songModel.currentAlbum);
          }

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
        } else if (page == "artistDetail") {
          final songModel = Provider.of<SongModel>(context, listen: false);

          if (songModel.currentArtist != songModel.currentSongsList) {
            songModel.setCurrentSongsList(songModel.currentArtist);
          }

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
        } else if (page == "artists") {
          final songModel = Provider.of<SongModel>(context, listen: false);
          final databaseHelper =
              Provider.of<DatabaseHelper>(context, listen: false);
          List<Song> artists =
              await databaseHelper.fetchArtistById(song.artistId);
          songModel.setArtist(artists);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ArtistDetails()));
        } else if (page == "nowPlaying") {
          final songModel = Provider.of<SongModel>(context, listen: false);
          bool newSong = songModel.currentSong == null
              ? true
              : songModel.currentSong != song;

          if (newSong) {
            songModel.setCurrentSong(song);
          }
          songModel.play(newSong);
        }
      },
    );
  }
}
