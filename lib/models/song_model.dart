import 'package:flutter/foundation.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongModel extends ChangeNotifier {
  SongInfo _currentSong;

  SongInfo get currentSong => _currentSong;

  set currentSong(SongInfo song) {
    _currentSong = song;
    notifyListeners();
  }
}
