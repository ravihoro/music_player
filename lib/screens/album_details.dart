import 'package:flutter/material.dart';
import 'package:music_player/widgets/custom_bottom_bar.dart';
import '../models/song_model.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_view.dart';

class AlbumDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        return Scaffold(
          backgroundColor: Colors.grey[850],
          body: (songModel.currentAlbum == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomView(page: "albumDetail"),
          bottomNavigationBar: Consumer<SongModel>(
            builder: (context, songModel, child) {
              //print(songModel.currentSong);
              return songModel.currentSong != null
                  ? CustomBottomBar()
                  : Container(
                      height: 0,
                    );
            },
          ),
        );
      },
    );
  }
}
