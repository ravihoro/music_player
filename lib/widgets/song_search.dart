import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import './custom_list_tile.dart';

class SongSearch extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search song';

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        return Container(
          color: Colors.grey[850],
          child: ListView.builder(
            itemCount: songModel.songs.length,
            itemBuilder: (context, index) {
              return songModel.songs[index].title
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      songModel.songs[index].album
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      songModel.songs[index].artist
                          .toLowerCase()
                          .contains(query.toLowerCase())
                  ? CustomListTile(songModel.songs[index], "songs", true)
                  : Container();
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.grey[850],
    );
  }
}
