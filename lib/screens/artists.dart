import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../widgets/custom_list_tile.dart';

class Artists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        if (songModel.artists == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
          itemCount: songModel.artists.length,
          itemBuilder: (context, index) {
            return CustomListTile(songModel.albums[index], "artists");
          },
        );
      },
    );
  }
}
