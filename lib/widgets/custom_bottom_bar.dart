import 'package:flutter/material.dart';
import '../util/utility.dart';
import '../screens/now_playing.dart';

class CustomBottomBar extends StatefulWidget {
  final songModel;

  CustomBottomBar({this.songModel});

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
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
              child: widget.songModel.currentSong.albumArtwork == null
                  ? CircleAvatar(
                      child: Text("NA", style: TextStyle(color: Colors.amber)),
                      backgroundColor: Colors.grey[850],
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(
                        getImage(widget.songModel.currentSong),
                      ),
                    ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NowPlaying()));
                },
                child: Text(
                  widget.songModel.currentSong.title,
                  overflow: TextOverflow.fade,
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
                widget.songModel.prev();
              },
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: widget.songModel.isPlaying
                    ? Icon(Icons.pause_circle_outline)
                    : Icon(Icons.play_circle_outline),
              ),
              onTap: () {
                if (widget.songModel.isPlaying) {
                  widget.songModel.pause();
                } else {
                  widget.songModel.play();
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
                widget.songModel.next();
              },
            ),
          ],
        ),
      ),
    );
  }
}
