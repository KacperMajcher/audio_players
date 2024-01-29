import 'package:audio_players/features/home/data/model/song.dart';

class PlaylistProvider {
  //playlist of songs
  final List<Song> _playlist = [
    Song(
        songName: 'Middle of the night',
        artistName: 'Elley Duhe',
        albumImagePath: 'assets/cover/cover.jpg',
        audioPath: 'audio/song.mp3'),
  ];
}
