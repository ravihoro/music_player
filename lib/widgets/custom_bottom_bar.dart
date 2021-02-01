import 'package:flutter/material.dart';
import '../util/utility.dart';
import '../screens/now_playing.dart';
import 'package:provider/provider.dart';
import '../models/song_model.dart';

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final songModel = Provider.of<SongModel>(context, listen: true);

    // return (songModel.currentSong == null)
    //     ? Container(
    //         height: 0,
    //       )
    //     : Container(
    //         height: 50,
    //         color: Colors.amber,
    //         child: Padding(
    //           padding: const EdgeInsets.all(5.0),
    //           child: Row(
    //             //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                 child: songModel.currentSong.albumArtwork == null
    //                     ? CircleAvatar(
    //                         backgroundImage: AssetImage(
    //                           "assets/images/music.jpg",
    //                         ),
    //                       )
    //                     : CircleAvatar(
    //                         backgroundImage: FileImage(
    //                           getImage(songModel.currentSong),
    //                         ),
    //                       ),
    //               ),
    //               Expanded(
    //                 child: InkWell(
    //                   onTap: () {
    //                     Navigator.of(context).push(MaterialPageRoute(
    //                         builder: (context) => NowPlaying()));
    //                   },
    //                   child: Text(
    //                     songModel.currentSong.title,
    //                     overflow: TextOverflow.fade,
    //                     softWrap: false,
    //                     style: TextStyle(
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               InkWell(
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                   child: Icon(
    //                     Icons.skip_previous,
    //                   ),
    //                 ),
    //                 onTap: () {
    //                   songModel.prev();
    //                 },
    //               ),
    //               InkWell(
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                   child: songModel.isPlaying
    //                       ? Icon(Icons.pause_circle_outline)
    //                       : Icon(Icons.play_circle_outline),
    //                 ),
    //                 onTap: () {
    //                   if (songModel.isPlaying) {
    //                     songModel.pause();
    //                   } else {
    //                     songModel.play();
    //                   }
    //                 },
    //               ),
    //               InkWell(
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                   child: Icon(
    //                     Icons.skip_next,
    //                   ),
    //                 ),
    //                 onTap: () {
    //                   songModel.next();
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //       );

    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        if (songModel.currentSong == null)
          return Container(
            height: 0,
          );
        return Container(
          height: 50,
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: songModel.currentSong.albumArtwork == null
                      ? CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/music.jpg",
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            getImage(songModel.currentSong),
                          ),
                        ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NowPlaying()));
                    },
                    child: Text(
                      songModel.currentSong.title,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.skip_previous,
                    ),
                  ),
                  onTap: () {
                    songModel.prev();
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: songModel.isPlaying
                        ? Icon(Icons.pause_circle_outline)
                        : Icon(Icons.play_circle_outline),
                  ),
                  onTap: () {
                    if (songModel.isPlaying) {
                      songModel.pause();
                    } else {
                      songModel.play();
                    }
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.skip_next,
                    ),
                  ),
                  onTap: () {
                    songModel.next();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
