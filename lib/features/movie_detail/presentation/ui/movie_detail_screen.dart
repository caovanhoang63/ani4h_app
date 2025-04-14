import 'package:ani4h_app/features/movie_detail/presentation/ui/widget/movie_player.dart';
import 'package:ani4h_app/features/movie_detail/presentation/ui/widget/movie_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final introVisibilityProvider = StateProvider<bool>((ref) => false);

class MovieDetailScreen extends ConsumerStatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isIntroVisible = ref.watch(introVisibilityProvider.state).state;

    return Scaffold(
      body: Stack(
        children: [
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
                        GestureDetector(
                          onTap: () {
                            ref.read(introVisibilityProvider.notifier).state = !isIntroVisible;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Movie Title',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Introduce',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.keyboard_arrow_right, color: Colors.white70, size: 24),
                                ]
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          spacing: 8,
                          children: [
                            MovieTag(tag: "Action"),
                            MovieTag(tag: "Adventure"),
                            MovieTag(tag: "Fantasy"),
                            MovieTag(tag: "Drama"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Playlist row
                        GestureDetector(
                          onTap: () {},
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
                          onTap: () {},
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
                  // The introduction component that slides in from top to bottom
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: isIntroVisible ? 0 : -(MediaQuery.of(context).size.height - (170)), // This controls the slide-in
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height - 50 - 100, // Full height minus movie player
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Movie Title',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref.read(introVisibilityProvider.notifier).state = !isIntroVisible;
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Introduce',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 24),
                                  ]
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                context.pop();
              },
            ),
          ),
        ]
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}