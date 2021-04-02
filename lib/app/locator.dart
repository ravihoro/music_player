import 'package:get_it/get_it.dart';
import 'package:music_player/services/database_helper.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import '../viewmodel/base_model.dart';
import '../viewmodel/home_viewmodel.dart';

var locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => DatabaseHelper());
  locator.registerLazySingleton(() => FlutterAudioQuery());
  locator.registerLazySingleton(() => HomeViewModel());
}
