import 'package:flutter/material.dart';
import 'package:music_player/app/locator.dart';
import './custom_list_tile.dart';
import '../viewmodel/base_model.dart';

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
    BaseModel model = locator<BaseModel>();
    return Container(
      color: Colors.grey[850],
      child: ListView.builder(
        itemCount: model.songs.length,
        itemBuilder: (context, index) {
          return model.songs[index].title
                  .toLowerCase()
                  .contains(query.toString().toLowerCase()) //||
              // model.songs[index].album
              //     .toLowerCase()
              //     .contains(query.toString().toLowerCase()) ||
              // model.songs[index].artist
              //     .toLowerCase()
              //     .contains(query.toString().toLowerCase())
              ? CustomListTile(model.songs[index], "songs", true)
              : Container();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.grey[850],
    );
  }
}
