import 'package:audio_players/features/details/data/model/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  //playlist of songs
  final List<Song> _playlist = [
    Song(
        songName: 'Middle of the night',
        artistName: 'Elley Duhe',
        albumImagePath: 'assets/cover/MiddleOfTheNightCover.jpg',
        audioPath: 'audio/MiddleOfTheNight.mp3'),
    Song(
        songName: 'Look at me!',
        artistName: 'XXXTENTATION',
        albumImagePath: 'assets/cover/LookAtMeCover.jpg',
        audioPath: 'audio/LookAtMe.mp3'),
    Song(
        songName: 'Skin and Bones',
        artistName: 'David Kushner',
        albumImagePath: 'assets/cover/SkinAndBonesCover.jpg',
        audioPath: 'audio/SkinAndBones.mp3'),
    Song(
        songName: 'BILLIE EILISH.',
        artistName: 'Armani White',
        albumImagePath: 'assets/cover/BillieEilishCover.jpg',
        audioPath: 'audio/BillieEilish.mp3'),
  ];

  //current song playing index
  int? _currentSongIndex;

  /* 
  
  A U D I O P L A Y E R

  */

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a specyfic position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play previous song
  void playPreviousSong() async {
    // if more than 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(const Duration(seconds: 0)); // seek to the beginning
    } else {
      // if it's within first 2 second of the song, go to previous song
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //if it is the first song, loop back to last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newPosition) {
      _totalDuration = newPosition;
      notifyListeners();
    });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  void playNextSong() {}

  /* 
  
  G E T T E R S

  */

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  AudioPlayer get audioPlayer => _audioPlayer;
  /* 
  
  S E T T E R S

  */

  set currentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // play the song at the new index
    }

    // update UI
    notifyListeners();
  }
}
