import 'package:flutter/material.dart';
import 'package:music_player/viewmodel/base_model.dart';
import 'package:stacked/stacked.dart';
import '../util/utility.dart';
import '../widgets/custom_list_tile.dart';
import '../models/song.dart';

class CustomView extends ViewModelWidget<BaseModel> {
  final String page;

  CustomView({this.page});

  @override
  Widget build(BuildContext context, BaseModel baseModel) {
    Song song = (page == "albumDetail")
        ? baseModel.currentAlbum[0]
        : baseModel.currentArtist[0];

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
                ? baseModel.currentAlbum.length
                : baseModel.currentArtist.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                  page == "albumDetail"
                      ? baseModel.currentAlbum[index]
                      : baseModel.currentArtist[index],
                  page);
            },
          ),
        ),
      ],
    );
  }
}

// class CustomView extends StatelessWidget {
//   final String page;

//   CustomView({this.page});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SongModel>(
//       builder: (context, songModel, child) {
//         Song song = (page == "albumDetail")
//             ? songModel.currentAlbum[0]
//             : songModel.currentArtist[0];

//         return Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 1 / 3,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: song.albumArtwork != null
//                       ? (FileImage(getImage(song)))
//                       : AssetImage("assets/images/music.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: page == "albumDetail"
//                     ? songModel.currentAlbum.length
//                     : songModel.currentArtist.length,
//                 itemBuilder: (context, index) {
//                   return CustomListTile(
//                       page == "albumDetail"
//                           ? songModel.currentAlbum[index]
//                           : songModel.currentArtist[index],
//                       page);
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
