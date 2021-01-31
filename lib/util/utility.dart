import 'dart:io';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import '../models/song.dart';

dynamic getImage(Song song) {
  return song.albumArtwork == null
      ? null
      : File.fromUri(Uri.parse(song.albumArtwork));
}
