import 'package:flutter/material.dart';
import 'package:music_player/viewmodel/home_viewmodel.dart';
import 'package:music_player/widgets/custom_bottom_bar.dart';
import 'package:stacked/stacked.dart';
import './songs_view.dart';
import './albums_view.dart';
import './artists_view.dart';
import '../app/locator.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.fetchSongsFromDatabase(),
      viewModelBuilder: () => locator<HomeViewModel>(),
      builder: (context, homeViewModel, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[850],
              centerTitle: true,
              title: Text(
                "Music Player",
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.amber,
                  onPressed: () {
                    //showSearch(context: context, delegate: SongSearch());
                  },
                ),
              ],
              bottom: TabBar(
                indicatorColor: Colors.amber,
                unselectedLabelColor: Colors.amber,
                tabs: [
                  Tab(
                    child: Text("Songs"),
                  ),
                  Tab(
                    child: Text("Albums"),
                  ),
                  Tab(
                    child: Text("Artists"),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.grey[850],
            body: TabBarView(
              children: [
                SongsView(),
                AlbumsView(),
                ArtistsView(),
              ],
            ),
            bottomNavigationBar: CustomBottomBar(),
          ),
        );
      },
    );
  }
}
