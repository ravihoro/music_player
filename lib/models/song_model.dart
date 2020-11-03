import 'package:flutter/foundation.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class SongModel extends ChangeNotifier {
  SongInfo _currentSong;
  bool _isPlaying = false;
  AudioPlayer player = AudioPlayer();
  List<SongInfo> _songs;

  SongInfo get currentSong => _currentSong;
  List<SongInfo> get songs => _songs;
  bool get isPlaying => _isPlaying;

  void setIsPlaying() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setCurrentSong(SongInfo song) {
    _currentSong = song;
    notifyListeners();
  }

  void setSongs(List<SongInfo> currentSongs) {
    _songs = currentSongs;
    //notifyListeners();
  }

  void next() {
    int index = _songs.indexOf(_currentSong);
    int length = _songs.length;
    index++;
    if (index >= length) {
      index = 0;
    }
    //print("Index is: $index");
    stop();
    _currentSong = songs[index];
    play();
  }

  void prev() {
    int index = _songs.indexOf(_currentSong);
    int length = _songs.length;
    index--;
    if (index < 0) {
      index = length - 1;
    }
    //print("Index is: $index");
    stop();
    _currentSong = songs[index];
    play();
  }

  void play() {
    player.setUrl(_currentSong.uri);
    player.play();
    if (!isPlaying) setIsPlaying();
  }

  void stop() {
    player.stop();
    if (isPlaying) setIsPlaying();
  }
}
