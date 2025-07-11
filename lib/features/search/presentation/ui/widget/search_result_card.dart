
import 'package:ani4h_app/common/provider/current_movie_state/current_movie_controller.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class SearchResultCard extends ConsumerWidget {
  final FilmCardModel item;
  const SearchResultCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final cardHeight = 160.0;
    final widthScreen = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        ref.read(currentMovieControllerProvider.notifier).fetchCurrentMovie(item.id);
        context.replaceNamed(movieDetailRoute);
      },
      child: Container(
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
                width: cardHeight*3/4,
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
                    width: cardHeight*3/4,
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
                SizedBox(
                  width: widthScreen - cardHeight*3/4 - 40,
                  child: Text(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                        genre.name,
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
                  width: widthScreen - cardHeight*3/4 - 40,
                  child: Text(
                    item.synopsis,
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
      ),
    );
  }
}