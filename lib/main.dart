import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/song_model.dart';
import './screens/songs.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SongModel>(
      create: (context) => SongModel(),
      child: Songs(),
    );
  }
}
