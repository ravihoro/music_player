import 'package:flutter/material.dart';
import 'package:music_player/viewmodel/base_model.dart';
import 'package:stacked/stacked.dart';
import '../widgets/custom_list_tile.dart';

class ArtistsView extends ViewModelWidget<BaseModel> {
  @override
  Widget build(BuildContext context, BaseModel model) {
    return model.artists == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: model.artists.length,
            itemBuilder: (context, index) {
              return CustomListTile(model.artists[index], "artists");
            },
          );
  }
}
