import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../viewmodel/base_model.dart';
import '../widgets/custom_list_tile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../util/utility.dart';

class NowPlayingView extends ViewModelWidget<BaseModel> {
  @override
  Widget build(BuildContext context, BaseModel model) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Now Playing',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
      body: SlidingUpPanel(
        color: Colors.white,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        minHeight: MediaQuery.of(context).size.height * 0.035,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              model.currentSong.title,
              overflow: TextOverflow.fade,
              softWrap: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              model.currentSong.artist,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Card(
                elevation: 10,
                shadowColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.amber,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: model.currentSong.albumArtwork != null
                          ? FileImage(
                              getImage(model.currentSong),
                            )
                          : AssetImage("assets/images/music.jpg"),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: StreamBuilder<Duration>(
                stream: model.player.durationStream,
                builder: (context, snapshot) {
                  var duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder(
                    stream: model.player.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return Slider(
                        min: 0.0,
                        max: duration.inMilliseconds.toDouble(),
                        activeColor: Colors.amber,
                        value: model.sliderValue ??
                            position.inMilliseconds.toDouble(),
                        onChanged: (val) {
                          if (val < duration.inMilliseconds.toDouble()) {
                            model.sliderValue = val;
                            model.player.seek(
                              Duration(
                                milliseconds: val.round(),
                              ),
                            );

                            // setState(() {
                            //   sliderValue = val;
                            //   model.player
                            //       .seek(Duration(milliseconds: val.round()));
                            //   // if (val ==
                            //   //     duration.inMilliseconds.toDouble()) {
                            //   //   songModel.next();
                            //   // }
                            // });
                          }
                        },
                        onChangeEnd: (endVal) {
                          model.sliderValue = null;
                          // setState(() {
                          //   sliderValue = null;
                          //   // songModel.player.seek(
                          //   //     Duration(milliseconds: endVal.round()));
                          // });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: model.player.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      return Text(
                        "${position.toString().substring(2, 7)}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  Text(
                    Duration(
                            milliseconds: int.parse(model.currentSong.duration))
                        .toString()
                        .substring(2, 7),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.skip_previous,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      //if (songModel.isPlaying) songModel.setIsPlaying();
                      model.prev();
                      //songModel.setIsPlaying();
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    color: Colors.amber,
                    icon: model.isPlaying
                        ? Icon(Icons.pause_circle_outline)
                        : Icon(Icons.play_circle_outline),
                    onPressed: () {
                      model.playPause();
                      //songModel.setIsPlaying();
                      // if (songModel.isPlaying) {
                      //   songModel.pause();
                      // } else {
                      //   songModel.play();
                      // }
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.skip_next,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      //if (songModel.isPlaying) songModel.setIsPlaying();
                      model.next();
                      //songModel.setIsPlaying();
                      //songModel.next();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        panel: Column(
          children: [
            Container(
              child: Icon(
                Icons.menu_sharp,
                size: 30,
              ),
              width: double.infinity,
              color: Colors.amber,
            ),
            Expanded(
              child: Container(
                color: Colors.grey[850],
                child: ListView.builder(
                  itemCount: model.currentSongsList.length,
                  itemBuilder: (context, index) {
                    return CustomListTile(
                        model.currentSongsList[index], "nowPlaying");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
