import 'package:flutter/material.dart';
import 'package:music_player/viewmodel/base_model.dart';
import 'package:stacked/stacked.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_view.dart';

class ArtistDetailView extends ViewModelWidget<BaseModel> {
  @override
  Widget build(BuildContext context, BaseModel baseModel) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: (baseModel.currentAlbum == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomView(page: "artistDetail"),
      bottomNavigationBar: baseModel.currentSong != null
          ? CustomBottomBar()
          : Container(
              height: 0,
            ),
    );
  }
}
