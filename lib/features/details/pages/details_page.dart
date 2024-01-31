import 'package:audio_players/features/details/data/model/playlist_provider.dart';
import 'package:audio_players/features/details/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetalsPageState();
}

class _DetalsPageState extends State<DetailsPage> {
  late String audioPath;
  final List<IconData> _icons = [
    Icons.play_circle,
    Icons.pause_circle,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      //convert duration into min:sec
      String formatTime(Duration duration) {
        String twoDigits =
            duration.inSeconds.remainder(60).toString().padLeft(2, '0');
        String formattedTime = '${duration.inMinutes}:$twoDigits';

        return formattedTime;
      }

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
                      max: value.totalDuration.inSeconds.toDouble(),
                      value: value.currentDuration.inSeconds.toDouble(),
                      onChanged: (double double) {
                        // during when the user is sliding around
                      },
                      onChangeEnd: (double double) {
                        // sliding has finished, go to that position in song duration
                        value.seek(Duration(seconds: double.toInt()));
                        // retume when finishing slide
                        value.resume();
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
                        Text(formatTime(value.currentDuration),
                            style: const TextStyle(color: Colors.white)),
                        Text(formatTime(value.totalDuration),
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
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.skip_previous_rounded,
                  //     size: 50,
                  //   ),
                  //   color: Colors.white,
                  //   onPressed: () => value.playPreviousSong(),
                  // ),
                  IconButton(
                      icon: Icon(
                        value.isPlaying ? _icons[1] : _icons[0],
                        size: 60,
                      ),
                      color: Colors.white,
                      onPressed: () => value.pauseOrResume()),
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.skip_next_rounded,
                  //     size: 50,
                  //   ),
                  //   color: Colors.white,
                  //   onPressed: () => value.playNextSong(),
                  // ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
