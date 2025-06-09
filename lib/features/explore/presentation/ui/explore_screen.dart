import 'dart:collection';

import 'package:ani4h_app/common/widget/loading_state_widget.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/presentation/controller/explore_controller.dart';
import 'package:ani4h_app/features/explore/presentation/ui/widget/explore_card.dart';
import 'package:ani4h_app/features/explore/presentation/ui/widget/tag_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final ScrollController _scrollController = ScrollController();

  List<Map<String,dynamic>> genres = [];

  final List<Map<String, dynamic>> seasons = [
    {"name": "Tất cả", "value": ""},
    {"name": "Spring", "value": "spring"},
    {"name": "Summer", "value": "summer"},
    {"name": "Fall", "value": "fall"},
    {"name": "winter", "value": "winter"},
  ];

  final List<Map<String, dynamic>> years = [
    {"name": "Tất cả", "value": null},
    {"name": "2024", "value": 2024},
    {"name": "2023", "value": 2023},
    {"name": "2022", "value": 2022},
    {"name": "2021", "value": 2021},
    {"name": "2020", "value": 2020},
    {"name": "2019", "value": 2019},
    {"name": "2018", "value": 2018},
    {"name": "2017", "value": 2017},
    {"name": "2016", "value": 2016},
    {"name": "2015", "value": 2015},
    {"name": "2014", "value": 2014},
    {"name": "2013", "value": 2013},
    {"name": "2012", "value": 2012},
    {"name": "2011", "value": 2011},
  ];

  int selectedCategory = 0;
  int selectedGenre = 0;
  int selectedYear = 0;
  int selectedType = 0;

  @override
  void initState() {
    super.initState();
    selectedGenre = 0; // Default to "Tất cả"
    selectedType = 0; // Default to "Tất cả"
    selectedYear = 0; // Default to "Tất cả"

    Future.microtask(() {
      ref.read(exploreControllerProvider.notifier).fetchGenres();

      firstFetchExplore();
    });

    _scrollController.addListener(_scrollListener);
  }

  void firstFetchExplore(){
    genres = ref.read(exploreControllerProvider).genreSelections;
    ref.read(exploreControllerProvider.notifier).fetchExplores(
        ExploreParams(
          genreId: genres.isNotEmpty ? genres[selectedGenre]['value'] : '',
          year: years.isNotEmpty ? years[selectedYear]['value'] : null,
          season: seasons.isNotEmpty ? seasons[selectedType]['value'] : '',
        )
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !ref.read(exploreControllerProvider).isLoading) {
      ref.read(exploreControllerProvider.notifier).fetchMoreExplores();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Explore
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Button Search
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: const Size(0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      context.push(searchRoute);
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            // List of filter

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Genre
                TagSelector(tags: ref.watch(exploreControllerProvider).genreSelections, selectedIndex: selectedGenre, onTagSelected: (index) {
                  setState(() {
                    selectedGenre = index;
                    firstFetchExplore();
                  });
                }),
                // Type
                TagSelector(tags: seasons, selectedIndex: selectedType, onTagSelected: (index) {
                  setState(() {
                    selectedType = index;
                    firstFetchExplore();
                  });
                }),
                //Year
                TagSelector(tags: years, selectedIndex: selectedYear, onTagSelected: (index) {
                  setState(() {
                    selectedYear = index;
                    firstFetchExplore();
                  });
                }),
              ],
            ),

            //Space
            const SizedBox(height: 16),

            // result
            // Expanded(
            //   child: GridView.builder(
            //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //       crossAxisSpacing: 8,
            //       childAspectRatio: 5.6/10,
            //     ),
            //     itemCount: ref.watch(exploreControllerProvider).explores.length,
            //     itemBuilder: (context, index) {
            //       return ExploreCard(item: ref.watch(exploreControllerProvider).explores[index]);
            //     },
            //   ),
            // ),

            Expanded(
              child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(exploreControllerProvider);

                    return
                    LoadingStateWidget(
                        isLoading: state.isLoading,
                        hasError: false,
                        errorMessage: state.errorMessage,
                        dataIsEmpty: state.explores.isEmpty,
                        child: GridView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            childAspectRatio: 5.6 / 10,
                          ),
                          itemCount: state.explores.length + (state.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == state.explores.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final item = state.explores[index];
                            return ExploreCard(item: item);
                          },
                        )
                    );
                  }
              ),
            )
          ]
        ),
      ),
    );
  }
}