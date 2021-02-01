import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/song_model.dart';
import '../widgets/custom_list_tile.dart';
import '../models/song.dart';

class Songs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        if (songModel.songs == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
          itemCount: songModel.songs.length,
          itemBuilder: (context, index) {
            return CustomListTile(songModel.songs[index], "songs");
          },
        );
      },
    );
  }
}
