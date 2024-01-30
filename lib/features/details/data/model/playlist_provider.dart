import 'package:audio_players/features/details/data/model/song.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  //playlist of songs
  final List<Song> _playlist = [
    Song(
        songName: 'Middle of the night',
        artistName: 'Elley Duhe',
        albumImagePath: 'assets/cover/cover.jpg',
        audioPath: 'audio/MiddleOfTheNight.mp3'),
    Song(
        songName: 'Look at me!',
        artistName: 'XXXTENTATION',
        albumImagePath: 'assets/cover/cover1.png',
        audioPath: 'audio/LookAtMe.mp3'),
    Song(
        songName: 'Skin and Bones',
        artistName: 'David Kushner',
        albumImagePath: 'assets/cover/cover2.png',
        audioPath: 'audio/SkinAndBones.mp3'),
    Song(
        songName: 'BILLIE EILISH.',
        artistName: 'Armani White',
        albumImagePath: 'assets/cover/cover3.png',
        audioPath: 'audio/BillieEilish.mp3'),
  ];

  //current song playing index
  int? _currentSongIndex;

  /* 
  
  G E T T E R S

  */

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  /* 
  
  S E T T E R S

  */

  set currentSongIndex(int? newIndex) {
    //update current song index
    _currentSongIndex = newIndex;

    //update UI
    notifyListeners();
  }
}
