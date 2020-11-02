import 'package:flutter/foundation.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongModel extends ChangeNotifier {
  SongInfo _currentSong;
  bool _isPlaying = false;

  SongInfo get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  void setIsPlaying() {
    _isPlaying = !_isPlaying;
  }

  void setCurrentSong(SongInfo song) {
    _currentSong = song;
    notifyListeners();
  }
}
