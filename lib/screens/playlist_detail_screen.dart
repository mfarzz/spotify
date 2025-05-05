import 'package:flutter/material.dart';
import 'package:spotify/constants.dart';
import 'package:spotify/widgets/music_card.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String playlistId;
  
  const PlaylistDetailScreen({
    super.key,
    this.playlistId = 'default',
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, fetch playlist data based on playlistId
    final title = playlistId == 'mix1' ? 'Daily Mix 1' : 
                  playlistId == 'mix2' ? 'Daily Mix 2' : 
                  playlistId == 'mix3' ? 'Daily Mix 3' : 
                  playlistId == 'mix4' ? 'Daily Mix 4' : 
                  'Chill Hits';
                  
    final imageUrl = playlistId == 'mix1' ? 'assets/mix1.jpg' : 
                     playlistId == 'mix2' ? 'assets/mix2.jpg' :
                     playlistId == 'mix3' ? 'assets/mix3.jpg' :
                     playlistId == 'mix4' ? 'assets/mix4.jpg' :
                     'assets/playlist3.jpg';

    return Scaffold(
      backgroundColor: darkGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: darkGrey,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              background: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'By Spotify • 2.3M likes • 50 songs, 2 hr 35 min',
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border, color: textGrey),
                      const SizedBox(width: 16),
                      const Icon(Icons.download_outlined, color: textGrey),
                      const SizedBox(width: 16),
                      const Icon(Icons.more_vert, color: textGrey),
                      const Spacer(),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: spotifyGreen,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
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
              MusicCard(
                imageUrl: 'assets/song3.jpg',
                title: 'Heat Waves',
                artist: 'Glass Animals',
                onTap: () {},
              ),
              MusicCard(
                imageUrl: 'assets/song1.jpg',
                title: 'Good 4 U',
                artist: 'Olivia Rodrigo',
                onTap: () {},
              ),
              MusicCard(
                imageUrl: 'assets/song2.jpg',
                title: 'Levitating',
                artist: 'Dua Lipa',
                onTap: () {},
              ),
              MusicCard(
                imageUrl: 'assets/song3.jpg',
                title: 'Industry Baby',
                artist: 'Lil Nas X, Jack Harlow',
                onTap: () {},
              ),
            ]),
          ),
        ],
      ),
    );
  }
}