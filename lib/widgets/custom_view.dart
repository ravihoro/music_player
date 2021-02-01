import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/song_model.dart';
import '../util/utility.dart';
import '../widgets/custom_list_tile.dart';
import '../models/song.dart';

class CustomView extends StatelessWidget {
  final String page;

  CustomView({this.page});

  @override
  Widget build(BuildContext context) {
    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        Song song = (page == "albumDetail")
            ? songModel.currentAlbum[0]
            : songModel.currentArtist[0];

        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1 / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: song.albumArtwork != null
                      ? (FileImage(getImage(song)))
                      : AssetImage("assets/images/music.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: page == "albumDetail"
                    ? songModel.currentAlbum.length
                    : songModel.currentArtist.length,
                itemBuilder: (context, index) {
                  return CustomListTile(
                      page == "albumDetail"
                          ? songModel.currentAlbum[index]
                          : songModel.currentArtist[index],
                      page);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
