import 'package:flutter/material.dart';
import 'package:spotify/constants.dart';
import 'package:spotify/widgets/music_card.dart';

class PlaylistScreen extends StatelessWidget {
  final String playlistId;
  
  const PlaylistScreen({
    super.key,
    required this.playlistId,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, fetch playlist data based on playlistId
    final title = playlistId == 'mix1' ? 'Daily Mix 1' : 
                  playlistId == 'discover' ? 'Discover Weekly' : 
                  'Playlist';
                  
    final imageUrl = playlistId == 'mix1' ? 'assets/playlist1.jpg' : 
                     playlistId == 'discover' ? 'assets/playlist2.jpg' :
                     'assets/playlist3.jpg';

    return Scaffold(
      backgroundColor: darkGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: darkGrey,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Songs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MusicCard(
                      imageUrl: 'assets/song1.jpg',
                      title: 'Blinding Lights',
                      artist: 'The Weeknd',
                      onTap: () {},
                    ),
                    MusicCard(
                      imageUrl: 'assets/song2.jpg',
                      title: 'Save Your Tears',
                      artist: 'The Weeknd',
                      onTap: () {},
                    ),
                    MusicCard(
                      imageUrl: 'assets/song3.jpg',
                      title: 'Stay',
                      artist: 'The Kid LAROI, Justin Bieber',
                      onTap: () {},
                    ),
                    MusicCard(
                      imageUrl: 'assets/song1.jpg',
                      title: 'Easy On Me',
                      artist: 'Adele',
                      onTap: () {},
                    ),
                    MusicCard(
                      imageUrl: 'assets/song2.jpg',
                      title: 'Bad Habits',
                      artist: 'Ed Sheeran',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}