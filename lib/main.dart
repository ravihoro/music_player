import 'package:flutter/material.dart';
import 'package:music_player/app/locator.dart';
import 'package:music_player/viewmodel/base_model.dart';
import 'package:stacked/stacked.dart';
import 'package:just_audio/just_audio.dart';
import './app/router.dart' as router;

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DemoApp(),
  );
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
      builder: (context, model, child) {
        return StreamBuilder(
          stream: model.player.processingStateStream,
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.active) {
            //   if (snapshot.data == ProcessingState.completed) {
            //     model.next();
            //     // WidgetsBinding.instance.addPostFrameCallback((_) {
            //     //   model.next();
            //     // });
            //   }
            // }

            if (snapshot.data == ProcessingState.completed) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                model.next();
              });
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              onGenerateRoute: router.Router.generateRoute,
            );
          },
        );
        //
        // return MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   initialRoute: '/',
        //   onGenerateRoute: router.Router.generateRoute,
        // );
      },
      viewModelBuilder: () => locator<BaseModel>(),
    );
  }
}
