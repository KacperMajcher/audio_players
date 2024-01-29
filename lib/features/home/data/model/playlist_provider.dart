import 'package:audio_players/features/home/data/model/song.dart';

class PlaylistProvider {
  //playlist of songs
  final List<Song> _playlist = [
    Song(
        songName: 'Middle of the night',
        artistName: 'Elley Duhe',
        albumImagePath: 'assets/cover/cover.jpg',
        audioPath: 'audio/song.mp3'),
        Song(
        songName: 'Look at me!',
        artistName: 'XXXTENTATION',
        albumImagePath: 'assets/cover/cover1.png',
        audioPath: 'audio/song.mp3'),
    Song(
        songName: 'Skin and Bones',
        artistName: 'David Kushner',
        albumImagePath: 'assets/cover/cover2.png',
        audioPath: 'audio/song.mp3'),
    Song(
        songName: 'BILLIE EILISH.',
        artistName: 'Armani White',
        albumImagePath: 'assets/cover/cover3.png',
        audioPath: 'audio/song.mp3'),
  ];
}
