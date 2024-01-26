import 'package:audio_players/features/home/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: SizedBox(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Image(
                image: AssetImage('assets/cover/cover.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Middle of the night',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Elley Duhe',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Slider(
                value: 0.5,
                min: 0,
                onChanged: (value) async {},
                activeColor: Colors.white,
                inactiveColor: Colors.white.withOpacity(0.3),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    size: 40,
                  ),
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_circle,
                    size: 50,
                  ),
                  color: Colors.white,
                  onPressed: () async {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    size: 40,
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
  }
}
