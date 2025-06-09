import 'package:ani4h_app/common/provider/current_movie_state/current_movie_controller.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/home/presentation/ui/widget/movie_card.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Correct import for CarouselSlider v5.0.0
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final carouselIndexProvider = StateProvider<int>((ref) {
  return 0; // Default to the first item
});

class MovieCarousel extends ConsumerStatefulWidget {
  final List<FilmCardModel> items;

  const MovieCarousel({super.key, required this.items});

  @override
  ConsumerState<MovieCarousel> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends ConsumerState<MovieCarousel> {
  late CarouselSliderController _carouselController; // Using CarouselSliderController for v5.0.0

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController(); // Initialize CarouselSliderController
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = ref.watch(carouselIndexProvider); // Get current index from Riverpod

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Using CarouselSlider for Infinite Scrolling
            CarouselSlider(
              items: widget.items.map((item) {
                // final index = widget.items.indexOf(item);
                return GestureDetector(
                  onTap: () {
                    ref.read(currentMovieControllerProvider.notifier).fetchCurrentMovie(item.id);
                    context.pushNamed(movieDetailRoute);
                  },
                  child: Stack(
                    children: [
                      // Background image container
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(item.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: MediaQuery.of(context).size.width * 1.3, // Adjust height for large image
                      ),
                      // Gradient at the bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black87, Colors.transparent],
                            ),
                          ),
                        ),
                      ),
                      // Movie name on the left (moves with the image)
                      Positioned(
                        bottom: 10,
                        left: 16,
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(blurRadius: 10.0, color: Colors.black, offset: Offset(0, 0)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              carouselController: _carouselController,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width * 1.3,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: true,
                scrollPhysics: ClampingScrollPhysics(),
                onPageChanged: (index, reason) {
                  setState(() {
                    ref.read(carouselIndexProvider.notifier).state = index;
                  });
                },
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
            ),
            // Page indicator (white dot) on the right, fixed in position on the image
            Positioned(
              bottom: 16,
              right: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.items.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      // When a dot is tapped, move to the respective page using the controller
                      _carouselController.animateToPage(index); // Move to the clicked index
                      ref.read(carouselIndexProvider.notifier).state = index; // Update the index in the state
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentIndex == index ? Colors.white : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: Center(
            //     child:
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
