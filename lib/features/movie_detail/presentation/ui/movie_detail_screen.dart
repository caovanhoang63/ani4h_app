import 'package:ani4h_app/common/provider/current_movie_state/current_movie_controller.dart';
import 'package:ani4h_app/features/home/presentation/ui/widget/movie_card.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/episode_detail_model.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/movie_detail_model.dart';
import 'package:ani4h_app/features/movie_detail/presentation/ui/widget/character_card.dart';
import 'package:ani4h_app/features/movie_detail/presentation/ui/widget/comment_card.dart';
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
  final TextEditingController _commentController = TextEditingController();

  // Since we don't have specific data for playlist parts, we'll keep this hardcoded
  final List<String> playlistParts = ['All Episodes'];

  // Track the currently selected playlist item
  String selectedIndex = "1";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MovieDetailModel? currentMovie = ref.watch(currentMovieControllerProvider.select((state) => state.movieDetail));
    List<EpisodeDetailModel> episodes = ref.watch(currentMovieControllerProvider.select((state) => state.episodes));

    EpisodeDetailModel? selectedEpisode;
    for (var ep in episodes) {
      if (ep.id == selectedIndex) {
        selectedEpisode = ep;
        break;
      }
    }

    // Initialize selectedIndex if episodes are loaded and selectedIndex is still default or invalid
    // This ensures an episode is selected when the screen loads or episodes become available.
    if (episodes.isNotEmpty && (selectedIndex == "1")) {
      Future.microtask(() {
        setState(() {
          selectedIndex = episodes.first.id;
        });
      });
    }

    bool isIntroVisible = ref.watch(movieDetailControllerProvider.select((state) => state.isIntroPanelOn));
    bool isPlaylistVisible = ref.watch(movieDetailControllerProvider.select((state) => state.isPlaylistPanelOn));
    bool isCommentVisible = ref.watch(movieDetailControllerProvider.select((state) => state.isCommentPanelOn));
    bool isCharacterExpandOn = ref.watch(movieDetailControllerProvider.select((state) => state.isCharacterExpandOn));
    bool isProducerExpandOn = ref.watch(movieDetailControllerProvider.select((state) => state.isProducerExpandOn));
    bool isStudioExpandOn = ref.watch(movieDetailControllerProvider.select((state) => state.isStudioExpandOn));

    final List<Comment> _comments = [
      Comment(id: 'c1', userAvatarUrl: '', username: 'Huy Bui', text: 'Good movie Combat', time: DateTime.now().subtract(const Duration(seconds: 5))),
      Comment(id: 'c2', userAvatarUrl: '', username: 'Royal', text: 'Good movie Combat', time: DateTime.now().subtract(const Duration(minutes: 5))),
      Comment(id: 'c3', userAvatarUrl: '', username: 'Thai Hoang', text: 'GoodddddddddddddddGoodddddddddddddddGoodddddddddddddddGoodddddddddddddddGoodddddddddddddddGooddddddddddddddd', time: DateTime.now().subtract(const Duration(hours: 5))),
    ];

    return Scaffold(
      body: Stack(
        children: [
          currentMovie == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              const SizedBox(height: 50),
              // Wrap in SizedBox to ensure consistent height
              SizedBox(
                width: double.infinity,
                height: 225, // Match the height in MoviePlayer
                child: // Show loading indicator when episode details are being fetched
                selectedEpisode == null
                    ? const Center(child: CircularProgressIndicator())
                    : MoviePlayer(
                  episode: selectedEpisode,
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentMovie.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,  // Adds the ellipsis when the text overflows
                                      maxLines: 1,  // Ensures the text stays on a single line
                                    ),
                                    if (selectedEpisode  != null)
                                      Text(
                                        'Episode ${selectedEpisode.episodeNumber}: ${selectedEpisode.title}',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                  ],
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
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(Icons.keyboard_arrow_right, color: Colors.white70, size: 24),
                                    ]
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          (currentMovie.genres.isEmpty)
                              ? const SizedBox(height: 8)
                              : SizedBox(
                              height: 30,
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: currentMovie.genres.length ?? 0, // Ensure itemCount is safe
                                itemBuilder: (context, index) {
                                  // Safely access the genre data and ensure we don't use movie data mistakenly
                                  final genre = currentMovie.genres[index]; // Assuming genres is not null here

                                  return MovieTag(tag: genre);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 8);  // Add 8px spacing between items
                                },
                              )
                          ),
                          const SizedBox(height: 20),
                          // Playlist row - only show if there are episodes
                          currentMovie.numEpisodes > 0 
                          ? GestureDetector(
                            onTap: () {
                              ref.read(movieDetailControllerProvider.notifier).openPlaylistPanel();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Playlist (${episodes.length} episodes)',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.keyboard_arrow_right, color: Colors.white70, size: 24),
                              ],
                            ),
                          )
                          : const SizedBox.shrink(),
                          const SizedBox(height: 12),
                          // Playlist buttons - only show if there are episodes
                          currentMovie.numEpisodes > 0 
                          ? SizedBox( // Give the ListView a defined height
                            height: 45, // Adjust height as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: episodes.length, // Use playlistItems here
                              itemBuilder: (context, index) {
                                final episode = episodes[index]; // Get the PlaylistItem
                                final isSelected = episode.id == selectedIndex;

                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: InkWell( // Make the container clickable
                                    onTap: () {
                                      // Update the selected index
                                      setState(() {
                                        selectedIndex = episode.id;
                                      });

                                      print('Tapped on item with ID: ${episode.id}, Index: ${episode.episodeNumber}, Url: ${episode.videoUrl}');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Added const
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.red : Colors.grey[800],
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: isSelected ? Colors.red : Colors.transparent,
                                        ),
                                      ),
                                      child: Text(
                                        episode.episodeNumber.toString(), // Display the item index
                                        style: const TextStyle( // Added const
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                );
                              },
                            ),
                          )
                          : const SizedBox.shrink(),
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
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                            ],
                          ),
                          // Suggested Movies
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'You may also like',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              (ref.read(currentMovieControllerProvider.select((value) => value.similarMovies.length)) > 0)
                                  ? SizedBox(
                                height: MediaQuery.of(context).size.width * 0.4,
                                child: ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ref.read(currentMovieControllerProvider.select((value) => value.similarMovies.length)),
                                  itemBuilder: (context, index) {
                                    return MovieCard(item: ref.read(currentMovieControllerProvider.select((value) => value.similarMovies))[index], isPush: false);
                                  },
                                ),
                              ) : const SizedBox(
                                height: 150,
                                child: Center(
                                  child: Text(
                                    'No suggestions available',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                    // Introduction Panel
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      top: isIntroVisible ? 0 : -(MediaQuery.of(context).size.height), // This controls the slide-in
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 225 - 50,
                        padding: EdgeInsets.all(16),
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
                                      fontSize: 16,
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
                                        style: TextStyle(color: Colors.white70, fontSize: 12),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 24),
                                    ]
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Genres List (Horizontal Scrollable)
                            (currentMovie.genres.isEmpty)
                              ? const SizedBox(height: 8) // Placeholder if no genres
                              : SizedBox(
                              height: 30, // Fixed height for horizontal list
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: currentMovie.genres.length ?? 0,
                                itemBuilder: (context, index) {
                                  final genre = currentMovie.genres[index];
                                  return MovieTag(tag: genre);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 8);
                                },
                              )
                            ),
                            const SizedBox(height: 12),
                            Expanded( // Makes this section fill the remaining height
                              child: SingleChildScrollView( // Makes the content inside vertically scrollable
                                physics: const AlwaysScrollableScrollPhysics(), // Ensure it's always scrollable if needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
                                  children: [
                                    // Synopsis Text
                                    Text(
                                      currentMovie.synopsis,
                                      style: const TextStyle( // Added const
                                        color: Colors.white,
                                        fontSize: 12,
                                        height: 1.5,
                                      ),
                                      overflow: TextOverflow.visible, // Ensure all text is visible
                                    ),
                                    const SizedBox(height: 16),
                                    GestureDetector(
                                      onTap: () => ref.read(movieDetailControllerProvider.notifier).toggleCharacterPanel(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Characters & Cast',
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                          Icon(isCharacterExpandOn ? Icons.expand_less : Icons.expand_more),
                                        ],
                                      ),
                                    ),
                                    if (isCharacterExpandOn)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12.0),
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: currentMovie.characters.length,
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 12,
                                            mainAxisSpacing: 12,
                                            childAspectRatio: 2.25 / 2,
                                          ),
                                          itemBuilder: (context, index) {
                                            final character = currentMovie.characters[index];
                                            return CharacterCard(character: character);
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    // Playlist Panel
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      top: isPlaylistVisible ? 0 : -(MediaQuery.of(context).size.height), // This controls the slide-in
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 225 - 50,
                        padding: EdgeInsets.all(16),
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
                                    'Playlist (${episodes.length} episodes)',
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 24),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 30, // Adjust height as needed
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: playlistParts.length,
                                itemBuilder: (context, index) {
                                  final partName = playlistParts[index];
                                  final isPartSelected = true; // Since we only have one part, it's always selected

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 24), // Added const
                                    child: GestureDetector( // Make parts clickable
                                      onTap: () {
                                        print('Tapped on Part: $partName');
                                      },
                                      child: Text(
                                        partName,
                                        style: TextStyle(
                                          color: isPartSelected ? Colors.red : Colors.white70, // Highlight selected part
                                          fontSize: 14,
                                          fontWeight: isPartSelected ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Grid of Playlist Items
                            Expanded(
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 50,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1,
                                ),
                                itemCount: episodes.length,
                                itemBuilder: (context, index) {
                                  final episode = episodes[index];
                                  final isSelected = episode.id == selectedIndex;
                                  return InkWell( // Make the grid item clickable
                                    onTap: () {
                                      print('Tapped on grid item with ID: ${episode.id}');
                                      setState(() {
                                        selectedIndex = episode.id;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(6), // Match container border radius for ripple effect
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.red : Colors.grey[800], // Highlight selected item
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: isSelected ? Colors.red : Colors.transparent,
                                          width: isSelected ? 2 : 0, // Thicker border for selected
                                        ),
                                      ),
                                      child: Center( // Center the text inside the container
                                        child: Text(
                                          episode.episodeNumber.toString(), // Display the item index (e.g., '1', '2')
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Comment Panel
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      top: isCommentVisible ? 0 : -(MediaQuery.of(context).size.height),
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 225 - 50,
                        padding: EdgeInsets.all(16),
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
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 24),
                                ],
                              ),
                            ),
                            // Comment list
                            Expanded(
                              child: ListView.separated(
                                itemCount: _comments.length,
                                itemBuilder: (context, index) {
                                  final comment = _comments[index];
                                  return CommentCard(comment: comment);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 12);
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Comment Input Area
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end, // Align items to the bottom
                              children: [
                                // Input Field
                                Expanded( // Make the input field fill available space
                                  child: TextField(
                                    controller: _commentController,
                                    style: const TextStyle(color: Colors.white), // Text color
                                    decoration: InputDecoration(
                                      hintText: 'Add a comment...',
                                      hintStyle: TextStyle(color: Colors.white54, fontSize: 12),
                                      filled: true,
                                      fillColor: Colors.grey[800], // Background color
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none, // No border line
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12), // Adjust padding
                                    ),
                                    maxLines: null, // Allow multiple lines
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                                const SizedBox(width: 8), // Space between input and button

                                // Comment Button
                                ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red, // Button color
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Comment',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 50,
            left: 0,
            child: InkWell(
              onTap: () {
                ref.read(currentMovieControllerProvider.notifier).clearCurrentMovie();
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 16,
                )
              )
            ),
          )
        ],
      ),
    );
  }
}
