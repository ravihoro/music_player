import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/widgets/custom_widgets.dart';

class Songs extends StatefulWidget {
  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs;

  @override
  void initState() {
    super.initState();
  }

  Future<List<SongInfo>> fetchSongs() async {
    //songs = await audioQuery.getSongs();
    //return songs;
    return await audioQuery.getSongs();
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Songs",
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
      body: FutureBuilder(
        future: fetchSongs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
              ),
            );
          }
          // songs.forEach((song) {
          //   print(song);
          // });
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return CustomListTile(snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
