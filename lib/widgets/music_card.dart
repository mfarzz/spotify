import 'package:flutter/material.dart';
import 'package:spotify/constants.dart';

class MusicCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;
  final VoidCallback onTap;

  const MusicCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    artist,
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: textGrey,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}