import 'dart:io';
import 'package:flutter_audio_query/flutter_audio_query.dart';

dynamic getImage(SongInfo song) {
  return song.albumArtwork == null
      ? null
      : File.fromUri(Uri.parse(song.albumArtwork));
}
