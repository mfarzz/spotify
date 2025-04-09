// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:spotify/constants.dart';

class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey, // Set background to darkGrey
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: darkGrey, // Replace gradient with darkGrey
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 300),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Chill Hits',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Kick back to the best new and recent chill hits.',
                                style: TextStyle(
                                  color: textGrey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/spotify_logo.png',
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Spotify',
                                    style: TextStyle(
                                      color: textGrey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '• 1,234,567 likes',
                                    style: TextStyle(
                                      color: textGrey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '• 3h 15m',
                                    style: TextStyle(
                                      color: textGrey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.favorite_border,
                                        color: spotifyGreen,
                                      ),
                                      const SizedBox(width: 24),
                                      Icon(
                                        Icons.download_outlined,
                                        color: spotifyGreen,
                                      ),
                                      const SizedBox(width: 24),
                                      Icon(
                                        Icons.more_vert,
                                        color: spotifyGreen,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: spotifyGreen,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                        vertical: 8.0,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.play_arrow,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'PLAY',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              const Divider(color: lightGrey),
                              const SizedBox(height: 16),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                separatorBuilder: (context, index) =>
                                    const Divider(color: lightGrey, height: 16),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: textGrey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    title: Text(
                                      'Song Title ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Artist ${index + 1}',
                                      style: const TextStyle(
                                        color: textGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: textGrey,
                                      ),
                                      onPressed: () {},
                                    ),
                                    onTap: () {
                                      // Play song
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/playlist3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            color: mediumGrey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Song Title',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Artist',
                        style: TextStyle(
                          color: textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}