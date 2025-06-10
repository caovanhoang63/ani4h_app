import 'package:ani4h_app/common/provider/current_movie_state/current_movie_controller.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/history/domain/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HistoryCard extends ConsumerWidget {
  final HistoryModel item;
  const HistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final cardHeight = 80.0;

    // Tính tiến độ đã xem
    final double progress = (item.duration > 0)
        ? (item.watchedDuration / item.duration).clamp(0.0, 1.0)
        : 0.0;

    return GestureDetector(
      onTap: () {
        ref.read(currentMovieControllerProvider.notifier).fetchCurrentMovie(item.filmId);
        context.replaceNamed(movieDetailRoute);
      },
      child: Container(
        height: cardHeight,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                  children: [
                    Image.network(
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

                    //Progress bar
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 4,
                        backgroundColor: Colors.grey,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
                    ),
                  ]
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
                  '${item.title} - Tập ${item.episodeNumber}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  item.viewCount > 0
                      ? '${item.viewCount} lượt xem'
                      : 'Chưa có lượt xem',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
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