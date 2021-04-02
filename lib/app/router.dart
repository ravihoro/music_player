import 'package:flutter/material.dart';
import 'package:music_player/view/album_detail_view.dart';
import 'package:music_player/view/artist_detail_view.dart';
import 'package:music_player/view/home_view.dart';
import 'package:music_player/view/now_playing_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeView(),
        );
        break;
      case '/now_playing':
        return MaterialPageRoute(builder: (_) => NowPlayingView());
        break;
      case '/album_detail':
        return MaterialPageRoute(builder: (_) => AlbumDetailView());
        break;
      case '/artist_detail':
        return MaterialPageRoute(builder: (_) => ArtistDetailView());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
        break;
    }
  }
}
