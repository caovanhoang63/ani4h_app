
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopSearchCard extends ConsumerWidget {
  final FilmCardModel item;
  const TopSearchCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref){
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
                if(loadingProgress == null) return child;
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

          //Name & Nation & tags
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - cardHeight*1.5 - 16 - 8 - 16,
                child: Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
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
                      genre,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ],
      ),
    );
  }
}