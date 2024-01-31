import 'package:audio_players/features/playlist/playlist_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PlaylistPage(),
    );
  }
}
