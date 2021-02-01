import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../widgets/custom_list_tile.dart';

class Albums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        if (songModel.albums == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
          itemCount: songModel.albums.length,
          itemBuilder: (context, index) {
            //return Text("Hello");
            return CustomListTile(songModel.albums[index], "albums");
          },
        );
      },
    );
  }
}
