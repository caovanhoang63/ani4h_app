import 'package:ani4h_app/common/provider/current_movie_state/current_movie_controller.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/explore/domain/model/explore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class ExploreCard extends ConsumerWidget {
  final ExploreCardModel item;
  const ExploreCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final cardWidth = (MediaQuery.of(context).size.width - 48)/3;

    return GestureDetector(
      onTap: () {
        ref.read(currentMovieControllerProvider.notifier).fetchCurrentMovie(item.id);
        context.pushNamed(movieDetailRoute);
      },
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: cardWidth,
                height: cardWidth * 4/3,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[300],
                    height: cardWidth,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    height: cardWidth,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.white, size: 50),
                    ),
                  );
                },
              ),
            ),
            //Name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}