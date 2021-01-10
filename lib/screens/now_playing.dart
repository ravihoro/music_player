import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';
import 'package:provider/provider.dart';
import '../util/utility.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> with TickerProviderStateMixin {
  double sliderValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<SongModel>(
        builder: (context, songModel, child) {
          return StreamBuilder(
            stream: songModel.player.processingStateStream,
            builder: (context, snapshot) {
              if (snapshot.data == ProcessingState.completed) {
                songModel.next();
              }
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    songModel.currentSong.title,
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 30,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    songModel.currentSong.artist,
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
                      child: songModel.currentSong.albumArtwork == null
                          ? Container(
                              clipBehavior: Clip.antiAlias,
                              alignment: Alignment.center,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.amber,
                                ),
                                color: Colors.black,
                              ),
                              child: Text(
                                "NA",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.amber,
                                ),
                              ),
                            )
                          : Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.amber,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    getImage(songModel.currentSong),
                                  ),
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
                      stream: songModel.player.durationStream,
                      builder: (context, snapshot) {
                        var duration = snapshot.data ?? Duration.zero;
                        return StreamBuilder(
                          stream: songModel.player.positionStream,
                          builder: (context, snapshot) {
                            var position = snapshot.data ?? Duration.zero;
                            if (position > duration) {
                              position = duration;
                            }
                            return Slider(
                              min: 0.0,
                              max: duration.inMilliseconds.toDouble(),
                              activeColor: Colors.amber,
                              value: sliderValue ??
                                  position.inMilliseconds.toDouble(),
                              onChanged: (val) {
                                setState(() {
                                  sliderValue = val;
                                  songModel.player.seek(
                                      Duration(milliseconds: val.round()));
                                  if (val ==
                                      duration.inMilliseconds.toDouble()) {
                                    //songModel.next();
                                    songModel.stop();
                                    //sliderValue = Duration.zero.inMilliseconds.toDouble();
                                  }
                                });
                              },
                              onChangeEnd: (endVal) {
                                setState(() {
                                  sliderValue = null;
                                  songModel.player.seek(
                                      Duration(milliseconds: endVal.round()));
                                });
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
                          stream: songModel.player.positionStream,
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
                                  milliseconds:
                                      int.parse(songModel.currentSong.duration))
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
                            songModel.prev();
                          },
                        ),
                        IconButton(
                          iconSize: 50,
                          color: Colors.amber,
                          icon: songModel.isPlaying
                              ? Icon(Icons.pause_circle_outline)
                              : Icon(Icons.play_circle_outline),
                          onPressed: () {
                            setState(() {
                              if (songModel.isPlaying) {
                                //player.setUrl(songModel.currentSong.uri);
                                songModel.player.pause();
                                songModel.setCurrentPosition(
                                    songModel.player.position);
                              } else {
                                songModel.player
                                    .setUrl(songModel.currentSong.uri);
                                songModel.player.play();
                              }
                              songModel.setIsPlaying();
                            });
                          },
                        ),
                        IconButton(
                          iconSize: 50,
                          icon: Icon(
                            Icons.skip_next,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            songModel.next();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
