import 'package:flutter/foundation.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song.dart';

class SongModel extends ChangeNotifier {
  Song _currentSong;
  bool _isPlaying = false;
  //bool pause = false;
  AudioPlayer player = AudioPlayer();
  ProcessingState _processingState = ProcessingState.none;
  List<Song> _songs;

  List<Song> _currentList;
  List<Song> _albumSongs;
  List<Song> _artistSongs;

  Duration _currentPosition = Duration.zero;

  Song get currentSong => _currentSong;
  List<Song> get songs => _songs;
  bool get isPlaying => _isPlaying;
  ProcessingState get processingState => _processingState;

  void setProcessingState(ProcessingState state) {
    _processingState = state;
    //notifyListeners();
  }

  void setCurrentPosition(Duration val) {
    _currentPosition = val;
  }

  void setIsPlaying() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setCurrentSong(Song song) {
    _currentSong = song;
    //notifyListeners();
  }

  void setSongs(List<Song> currentSongs) {
    print(currentSongs.length);
    _songs = currentSongs;
    notifyListeners();
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
    play(true);
  }

  void prev() {
    int index = _songs.indexOf(_currentSong);
    int length = _songs.length;
    index--;
    if (index < 0) {
      index = length - 1;
    }
    stop();
    _currentSong = songs[index];
    play(true);
  }

  void pause() {
    player.pause();
    if (isPlaying) setIsPlaying();
  }

  void play([bool newSong = false]) {
    if (newSong) player.setUrl(_currentSong.uri);
    player.play();
    if (!isPlaying) setIsPlaying();
  }

  void stop() {
    player.stop();
    if (isPlaying) setIsPlaying();
  }
}
