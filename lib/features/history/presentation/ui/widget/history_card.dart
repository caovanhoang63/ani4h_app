import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryItem {
  final String id;
  final String name;
  final String nation;
  final String imageUrl;
  final List<String> tags;

  HistoryItem({
    required this.id,
    required this.name,
    required this.nation,
    required this.imageUrl,
    required this.tags,
  });
}

class HistoryCard extends ConsumerWidget {
  final HistoryItem item;
  const HistoryCard({super.key, required this.item});

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
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                item.nation,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: item.tags.map((tag) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8, top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tag,
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