import 'package:stacked/stacked.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song.dart';

class BaseModel extends BaseViewModel {
  Song _currentSong;
  bool _isPlaying = false;

  double _sliderValue = 0.0;

  get sliderValue => _sliderValue;

  set sliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  //bool pause = false;
  AudioPlayer player = AudioPlayer();
  //ProcessingState _processingState = ProcessingState.none;
  List<Song> _songs; // Songs page displayed using this list
  List<Song> _currentSongsList; // Songs playing from this list

  List<Song> _albums; // Distinct songs in albums to display in albums page
  List<Song> _artists; // Distinct songs by artitst to display in artists page

  List<Song> get currentSongsList => _currentSongsList;

  List<Song> _currentAlbum;
  List<Song> _currentArtist;

  //Duration _currentPosition = Duration.zero;

  List<Song> get albums => _albums;
  List<Song> get artists => _artists;
  List<Song> get currentAlbum =>
      _currentAlbum; // to display songs in particular album
  List<Song> get currentArtist =>
      _currentArtist; // to display songs bt particular artist

  Song get currentSong => _currentSong; //current song playing

  List<Song> get songs => _songs;

  bool get isPlaying => _isPlaying;

  //ProcessingState get processingState => _processingState;

  // void setProcessingState(ProcessingState state) {
  //   _processingState = state;
  //   //notifyListeners();
  // }

  // void setCurrentPosition(Duration val) {
  //   _currentPosition = val;
  // }

  void setCurrentSong(Song song) {
    _currentSong = song;
    //notifyListeners();
  }

  void setSongs(List<Song> currentSongs) {
    //print(currentSongs.length);
    _songs = currentSongs;
    notifyListeners();
  }

  void setCurrentSongsList(List<Song> currentSongs) {
    //print(currentSongs.length);
    _currentSongsList = currentSongs;
    notifyListeners();
  }

  void setAlbums(List<Song> albums) {
    _albums = albums;
    notifyListeners();
  }

  void setAlbum(List<Song> album) {
    _currentAlbum = album;
    notifyListeners();
  }

  void setArtists(List<Song> artists) {
    _artists = artists;
    notifyListeners();
  }

  void setArtist(List<Song> artist) {
    _currentArtist = artist;
    notifyListeners();
  }

  void setIsPlaying() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void next() {
    int index = _currentSongsList.indexOf(_currentSong);
    int length = _currentSongsList.length;
    index++;
    if (index >= length) {
      index = 0;
    }
    //if (isPlaying) setIsPlaying();
    // if (songFinished)
    //   player.stop();
    // else {
    //   if (isPlaying) setIsPlaying();
    // }
    //player.stop();
    _currentSong = _currentSongsList[index];
    playPause(true);
    //play(true);
    //if (!isPlaying) setIsPlaying();
  }

  void prev() {
    int index = _currentSongsList.indexOf(_currentSong);
    int length = _currentSongsList.length;
    index--;
    if (index < 0) {
      index = length - 1;
    }
    //if (isPlaying) setIsPlaying();
    //player.stop();
    _currentSong = _currentSongsList[index];
    playPause(true);
    //play(true);
    //if (!isPlaying) setIsPlaying();
  }

  void pause() {
    player.pause();
    setIsPlaying();
    //if (isPlaying) setIsPlaying();
    //notifyListeners();
    //if (isPlaying) setIsPlaying();
  }

  void playPause([bool newSong = false]) {
    if (isPlaying && newSong) {
      player.stop();
      player.setUrl(_currentSong.uri);
      player.play();
      notifyListeners();
    } else if (!isPlaying && newSong) {
      player.stop();
      player.setUrl(_currentSong.uri);
      player.play();
      setIsPlaying();
    } else if (isPlaying && !newSong) {
      player.pause();
      setIsPlaying();
    } else {
      player.play();
      setIsPlaying();
    }

    // if (isPlaying && !newSong) {
    //   player.pause();
    // } else {
    //   if (newSong) player.setUrl(_currentSong.uri);
    //   player.play();
    // }
    //setIsPlaying();
  }

  void play([bool newSong = false]) {
    if (newSong) player.setUrl(_currentSong.uri);
    player.play();
    setIsPlaying();
    //if (!isPlaying) setIsPlaying();
    //notifyListeners();
    //if (!isPlaying) setIsPlaying();
  }

  void stop() {
    player.stop();
    //if (isPlaying) setIsPlaying();
    //notifyListeners();
  }
}
