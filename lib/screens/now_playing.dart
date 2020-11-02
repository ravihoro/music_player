import 'package:flutter/material.dart';
import 'package:music_player/screens/songs.dart';
import '../models/song_model.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  double sliderValue = 0.0;

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      iconSize: 50,
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 50,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      color: Colors.white,
                      iconSize: 50,
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
