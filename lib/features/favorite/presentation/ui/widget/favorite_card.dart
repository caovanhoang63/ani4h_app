import 'package:ani4h_app/features/favorite/domain/model/favorite_model.dart';
import 'package:ani4h_app/features/favorite/presentation/controller/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FavoriteCard extends ConsumerWidget {
  final FavoriteModel item;
  const FavoriteCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardHeight = 80.0;

    return Container(
      height: cardHeight,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl,
              width: cardHeight*1.5,
              height: cardHeight,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  height: cardHeight,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  height: cardHeight,
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.white, size: 50),
                  ),
                );
              },
            ),
          ),

          //Space
          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      item.avgStar.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                  ],
                ),
                Row(
                  children: item.genres.take(3).map((genre) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8, top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        genre.name,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),

          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  ref.read(favoriteControllerProvider.notifier).removeFavorite(item.id);
                },
                icon: Icon(Icons.remove_circle_outline, color: Colors.grey, size: 24)
            ),
          )
        ],
      ),
    );
  }
}