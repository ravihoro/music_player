import 'package:flutter/material.dart';

class AlbumDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          SliverList(),
        ],
      ),
    );
  }
}
