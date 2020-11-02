import 'package:flutter/material.dart';
import 'package:music_player/screens/songs.dart';
import '../models/song_model.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> with TickerProviderStateMixin {
  double sliderValue = 0.0;

  AnimationController _animationController;
  var isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
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
                        image: AssetImage(
                          songModel.currentSong.albumArtwork,
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
                child: Slider(
                  //divisions: 100,
                  value: sliderValue,
                  activeColor: Colors.amber,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
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
                    Text(
                      "00:00",
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 50,
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _animationController,
                      ),
                      onPressed: () {
                        setState(() {
                          songModel.setIsPlaying();
                          if (songModel.isPlaying) {
                            //songModel.setIsPlaying();
                            _animationController.forward();
                          } else {
                            //songModel.setIsPlaying();
                            _animationController.reverse();
                          }
                        });
                      },
                    ),
                    IconButton(
                      iconSize: 50,
                      icon: Icon(
                        Icons.skip_next,
                      ),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
