import 'package:ani4h_app/core/provider/current_movie_state/current_movie_controller.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/movie_model.dart';
import 'package:ani4h_app/features/movie_detail/presentation/ui/widget/movie_player.dart';
import 'package:ani4h_app/features/movie_detail/presentation/ui/widget/movie_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controller/movie_detail_controller.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MovieModel? currentMovie = ref.watch(currentMovieControllerProvider.select((state) => state.movieDetail));

    bool isIntroVisible = ref.watch(movieDetailControllerProvider.select((state) => state.isIntroPanelOn));
    bool isPlaylistVisible = ref.watch(movieDetailControllerProvider.select((state) => state.isPlaylistPanelOn));
    bool isCommentVisible = ref.watch(movieDetailControllerProvider.select((state) => state.isCommentPanelOn));

    return Scaffold(
      body: Stack(
        children: [
          currentMovie == null
              ?
          const Center(child: CircularProgressIndicator())
              :
          Column(
            children: [
              const SizedBox(height: 50),
              MoviePlayer(),
              Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                currentMovie.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,  // Adds the ellipsis when the text overflows
                                maxLines: 1,  // Ensures the text stays on a single line
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                ref.read(movieDetailControllerProvider.notifier).openIntroPanel();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Introduce',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.keyboard_arrow_right, color: Colors.white70, size: 24),
                                ]
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        (currentMovie.genres == null || currentMovie.genres!.isEmpty)
                            ? const SizedBox(height: 8)
                            : SizedBox(
                          height: 30,
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: currentMovie.genres?.length ?? 0, // Ensure itemCount is safe
                            itemBuilder: (context, index) {
                              // Safely access the genre data and ensure we don't use movie data mistakenly
                              final genre = currentMovie.genres![index]; // Assuming genres is not null here

                              return MovieTag(tag: genre);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 8);  // Add 8px spacing between items
                            },
                          )
                        ),
                        const SizedBox(height: 20),
                        // Playlist row
                        GestureDetector(
                          onTap: () {
                            ref.read(movieDetailControllerProvider.notifier).openPlaylistPanel();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Playlist',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Icon(Icons.keyboard_arrow_right, color: Colors.white70, size: 24),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Playlist buttons
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(10, (index) {
                              final isSelected = index == 0;
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.red : Colors.grey[800],
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isSelected ? Colors.red : Colors.transparent,
                                  ),
                                ),
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Comment Row
                        GestureDetector(
                          onTap: () {
                            ref.read(movieDetailControllerProvider.notifier).openCommentPanel();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Comment',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Icon(Icons.keyboard_arrow_right, color: Colors.white70, size: 24),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Bottom icon buttons
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              iconSize: 35,
                              icon: Icon(Icons.add_circle_outline, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 35,
                              icon: Icon(Icons.download_outlined, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 35,
                              icon: Icon(Icons.share_outlined, color: Colors.white),
                            ),
                          ],
                        ),
                        // Using the custom FloatingPanel widget
                      ],
                    )
                  ),
                  // Introduction Panel
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: isIntroVisible ? 0 : -(MediaQuery.of(context).size.height - (170)), // This controls the slide-in
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 50 - 100,
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    currentMovie.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,  // Adds the ellipsis when the text overflows
                                    maxLines: 1,  // Ensures the text stays on a single line
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref.read(movieDetailControllerProvider.notifier).closeAllPanels();
                                  },
                                  child: Row(
                                      children: [
                                        Text(
                                          'Introduce',
                                          style: TextStyle(color: Colors.white70),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 24),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            (currentMovie.genres == null || currentMovie.genres!.isEmpty)
                                ? const SizedBox(height: 8)
                                : SizedBox(
                                height: 30,
                                child: ListView.separated(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: currentMovie.genres?.length ?? 0, // Ensure itemCount is safe
                                  itemBuilder: (context, index) {
                                    // Safely access the genre data and ensure we don't use movie data mistakenly
                                    final genre = currentMovie.genres![index]; // Assuming genres is not null here

                                    return MovieTag(tag: genre);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 8);  // Add 8px spacing between items
                                  },
                                )
                            ),
                            const SizedBox(height: 12),
                            // Synopsis
                            currentMovie.synopsis != null
                                ? Text(
                              currentMovie.synopsis!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.5,
                              ),
                              overflow: TextOverflow.visible,
                            ) : const SizedBox(height: 8),
                          ],
                        ),
                      )
                    ),
                  ),
                  // Playlist Panel
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: isPlaylistVisible ? 0 : -(MediaQuery.of(context).size.height - (170)), // This controls the slide-in
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 50 - 100,
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(movieDetailControllerProvider.notifier).closeAllPanels();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Playlist',
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 24),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                  // Comment Panel
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: isCommentVisible ? 0 : -(MediaQuery.of(context).size.height - (170)),
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 50 - 100,
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(movieDetailControllerProvider.notifier).closeAllPanels();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Comment',
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 24),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 50,
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                ref.read(currentMovieControllerProvider.notifier).clearCurrentMovie();
                context.pop();
              },
            ),
          ),
        ]
      )
    );
  }
}