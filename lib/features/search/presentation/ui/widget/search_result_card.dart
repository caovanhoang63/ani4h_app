
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResultItem {
  final String id;
  final String name;
  final String nation;
  final String imageUrl;
  final List<String> tags;
  final String description;

  SearchResultItem({
    required this.id,
    required this.name,
    required this.nation,
    required this.imageUrl,
    required this.tags,
    required this.description,
  });
}

class SearchResultCard extends ConsumerWidget {
  final SearchResultItem item;
  const SearchResultCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final cardHeight = 180.0;
    final widthScreen = MediaQuery.of(context).size.width;

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
              width: cardHeight*2/3,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
              ),
              //Space
              const SizedBox(height: 2),
              //Description
              SizedBox(
                width: widthScreen - cardHeight*2/3 - 40,
                child: Text(
                  item.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}