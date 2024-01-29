import 'package:audio_players/core/app.dart';
import 'package:audio_players/features/details/data/model/playlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PlaylistProvider(),
      child: const App(),
    ),
  );
}
