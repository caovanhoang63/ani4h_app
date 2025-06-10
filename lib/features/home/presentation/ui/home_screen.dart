import 'package:ani4h_app/core/data/remote/token/token_service.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/home/presentation/controller/home_controller.dart';
import 'package:ani4h_app/features/home/presentation/ui/widget/movie_card.dart';
import 'package:ani4h_app/features/home/presentation/ui/widget/movie_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainTabState();
}

class _MainTabState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(homeControllerProvider.notifier).fetchCarouselMovies();
      ref.read(homeControllerProvider.notifier).fetchTopHot();
      ref.read(homeControllerProvider.notifier).fetchUserFavorite();
      ref.read(homeControllerProvider.notifier).fetchUserHistorySuggestion();
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      appBarOpacity = (_scrollController.offset / (MediaQuery.of(context).size.height / 3)).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Body content
          RefreshIndicator(
            onRefresh: () async {
              ref.read(homeControllerProvider.notifier).fetchCarouselMovies();
              ref.read(homeControllerProvider.notifier).fetchTopHot();
              ref.read(homeControllerProvider.notifier).fetchUserFavorite();
              ref.read(homeControllerProvider.notifier).fetchUserHistorySuggestion();

            },
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(top: 0),
              controller: _scrollController,
              children: [
                MovieCarousel(items: homeState.carouselMovies),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You may like',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (homeState.topSearches.isNotEmpty)
                          ? SizedBox(
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: homeState.topSearches.length,
                          itemBuilder: (context, index) {
                            return MovieCard(item: homeState.topSearches[index]);
                          },
                        ),
                      ) : const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ani4H Hot',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (ref.read(homeControllerProvider.select((value) => value.userFavorite.length)) > 0)
                          ? SizedBox(
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: ref.read(homeControllerProvider.select((value) => value.userFavorite.length)),
                          itemBuilder: (context, index) {
                            return MovieCard(item: ref.read(homeControllerProvider.select((value) => value.userFavorite))[index]);
                          },
                        ),
                      ) : const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Proposal for you',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (ref.read(homeControllerProvider.select((value) => value.userHistorySuggestion.length)) > 0)
                          ? SizedBox(
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: ref.read(homeControllerProvider.select((value) => value.userHistorySuggestion.length)),
                          itemBuilder: (context, index) {
                            return MovieCard(item: ref.read(homeControllerProvider.select((value) => value.userHistorySuggestion))[index]);
                          },
                        ),
                      ) : const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // AppBar with scroll opacity effect
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.black.withAlpha((appBarOpacity * 255).toInt()),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: GestureDetector(
                  onTap: () {
                    context.push(searchRoute);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((127).toInt()), // Adjust opacity of the text holder
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tìm kiếm',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
