import 'package:audio_players/features/details/data/model/playlist_provider.dart';
import 'package:audio_players/features/details/widgets/app_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetalsPageState();
}

class _DetalsPageState extends State<DetailsPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  late String audioPath;
  final List<IconData> _icons = [
    Icons.play_circle,
    Icons.pause_circle,
  ];

  @override
  void initState() {
    super.initState();

    // Get the playlist and current song
    final playlistProvider =
        Provider.of<PlaylistProvider>(context, listen: false);
    final playlist = playlistProvider.playlist;
    final currentSong = playlist[playlistProvider.currentSongIndex ?? 0];

    // Set the audio path
    audioPath = currentSong.audioPath;

    setAudio(audioPath);

    //Listen to the states: playing, paused, stopped
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    //listen to audio duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    //listen to audio position changes
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      //get playlist
      final playlist = value.playlist;

      //get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];

      //return scaffold UI
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: const CustomAppBar(),
        body: SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 45),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Image(
                  image: AssetImage(currentSong.albumImagePath),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong.songName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          currentSong.artistName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Slider(
                      min: 0,
                      max: _duration.inSeconds.toDouble(),
                      value: _position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await _audioPlayer.seek(position);

                        //optional: play audio if was paused
                        await _audioPlayer.resume();
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(_position),
                            style: const TextStyle(color: Colors.white)),
                        Text(formatTime(_duration),
                            //formatTime(_duration - _position), //reamining time of the song
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 50,
                    ),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: _isPlaying == false
                        ? Icon(
                            _icons[0],
                            size: 60,
                          )
                        : Icon(
                            _icons[1],
                            size: 60,
                          ),
                    color: Colors.white,
                    onPressed: () async {
                      if (_isPlaying) {
                        await _audioPlayer.pause();
                      } else {
                        await _audioPlayer.resume();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      size: 50,
                    ),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Future setAudio(String audioPath) async {
    //Repeat song when completed
    _audioPlayer.setReleaseMode(ReleaseMode.loop);

    //load audio
    await _audioPlayer.play(AssetSource(audioPath));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}
