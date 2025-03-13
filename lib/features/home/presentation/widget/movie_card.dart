import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieItem {
  final String name;
  final String horizontalImage;
  final String verticalImage;
  final String type;

  MovieItem({required this.name, required this.horizontalImage, required this.verticalImage, required this.type});
}

class MovieCard extends ConsumerWidget {
  final MovieItem item;

  const MovieCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardWidth = MediaQuery.of(context).size.width * 0.4;
    final cardHeight = cardWidth * 0.9;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      ),
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.horizontalImage,
              width: cardWidth,
              height: cardHeight * 0.8,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  height: cardHeight * 0.8,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              // Show Error Icon if Image Fails to Load
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  height: cardHeight * 0.8,
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.red, size: 50),
                  ),
                );
              },
            ),
          ),

          // Type Badge
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item.type,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Title
          Positioned(
            bottom: 0,  // Position the title at the bottom of the card
            left: 0,
            right: 8,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis, // To handle long titles
              ),
            ),
          ),

        ],
      ),
    );
  }
}