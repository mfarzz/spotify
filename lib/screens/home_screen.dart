import 'package:flutter/material.dart';
import 'package:spotify/constants.dart';
import 'package:spotify/widgets/music_card.dart';
import 'package:spotify/widgets/playlist_card.dart';
import 'package:spotify/screens/playlist_screen.dart';
import 'package:spotify/screens/playlist_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGrey,
        title: const Text(
          'Good afternoon',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.history), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: darkGrey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recently played section
                const Text(
                  'Recently played',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      PlaylistCard(
                        imageUrl: 'assets/playlist1.jpg',
                        title: 'Daily Mix 1',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlaylistScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      PlaylistCard(
                        imageUrl: 'assets/playlist2.jpg',
                        title: 'Discover Weekly',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlaylistScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      PlaylistCard(
                        imageUrl: 'assets/playlist3.jpg',
                        title: 'Chill Hits',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const PlaylistDetailScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      PlaylistCard(
                        imageUrl: 'assets/playlist4.jpg',
                        title: 'Rock Classics',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Made for you section
                const Text(
                  'Made for you',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildCategoryCard('Daily Mix 1', 'assets/mix1.jpg'),
                    _buildCategoryCard('Daily Mix 2', 'assets/mix2.jpg'),
                    _buildCategoryCard('Daily Mix 3', 'assets/mix3.jpg'),
                    _buildCategoryCard('Daily Mix 4', 'assets/mix4.jpg'),
                  ],
                ),
                const SizedBox(height: 24),
                // Recently played tracks
                const Text(
                  'Recently played tracks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: textGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Your Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Premium',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Navigate to playlist detail
      },
      child: Container(
        decoration: BoxDecoration(
          color: mediumGrey,
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
