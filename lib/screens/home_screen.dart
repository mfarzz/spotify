import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/constants.dart';
import 'package:spotify/widgets/music_card.dart';
import 'package:spotify/widgets/playlist_card.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;
  
  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/search');
              break;
            case 2:
              context.go('/library');
              break;
            case 3:
              context.go('/account');
              break;
          }
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
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrey,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: darkGrey,
            pinned: true,
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
          SliverToBoxAdapter(
            child: _buildHomeBody(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String imageUrl, String id) {
    return GestureDetector(
      onTap: () {
        context.push('/playlist/$id/detail');
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

  Widget _buildHomeBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    context.push('/playlist/mix1');
                  },
                ),
                const SizedBox(width: 16),
                PlaylistCard(
                  imageUrl: 'assets/playlist2.jpg',
                  title: 'Discover Weekly',
                  onTap: () {
                    context.push('/playlist/discover');
                  },
                ),
                const SizedBox(width: 16),
                PlaylistCard(
                  imageUrl: 'assets/playlist3.jpg',
                  title: 'Chill Hits',
                  onTap: () {
                    context.push('/playlist/chill/detail');
                  },
                ),
                const SizedBox(width: 16),
                PlaylistCard(
                  imageUrl: 'assets/playlist4.jpg',
                  title: 'Rock Classics',
                  onTap: () {
                    context.push('/playlist/rock');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
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
              _buildCategoryCard(context, 'Daily Mix 1', 'assets/mix1.jpg', 'mix1'),
              _buildCategoryCard(context, 'Daily Mix 2', 'assets/mix2.jpg', 'mix2'),
              _buildCategoryCard(context, 'Daily Mix 3', 'assets/mix3.jpg', 'mix3'),
              _buildCategoryCard(context, 'Daily Mix 4', 'assets/mix4.jpg', 'mix4'),
            ],
          ),
          const SizedBox(height: 24),
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
    );
  }
}

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrey,
      child: Center(
        child: Text(
          'Search Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrey,
      child: Center(
        child: Text(
          'Your Library',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}