import 'package:flutter/material.dart';
import 'package:spotify/constants.dart';
import 'package:spotify/widgets/music_card.dart';
import 'package:spotify/screens/playlist_detail_screen.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: darkGrey,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/playlist1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daily Mix 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Made for you • Updated daily',
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: spotifyGreen,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.download_outlined,
                        color: spotifyGreen,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.more_vert,
                        color: spotifyGreen,
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: spotifyGreen,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.play_arrow),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '50 songs • about 3 hr 15 min',
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: lightGrey),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MusicCard(
                  imageUrl: 'assets/song${index % 4 + 1}.jpg',
                  title: 'Song Title ${index + 1}',
                  artist: 'Artist ${index + 1}',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlaylistDetailScreen(),
                      ),
                    );
                  },
                );
              },
              childCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}