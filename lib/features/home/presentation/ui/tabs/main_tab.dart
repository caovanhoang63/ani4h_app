import 'package:ani4h_app/features/home/presentation/widget/movie_card.dart';
import 'package:ani4h_app/features/home/presentation/widget/movie_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTab extends ConsumerStatefulWidget {
  const MainTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainTabState();
}

class _MainTabState extends ConsumerState<MainTab> {
  ScrollController _scrollController = ScrollController();
  double appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
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
    final items = [
      MovieItem(
        name: 'Nise Koi',
        horizontalImage: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
        verticalImage: 'https://m.media-amazon.com/images/M/MV5BMzcxMjBiNWMtNDBmYi00NmFlLWFlOTctZjlkMzExMWU0YTI5XkEyXkFqcGc@._V1_.jpg',
        type: 'HD Vietsub',
      ),
      MovieItem(
        name: 'Mayonaka Heart Tune',
        horizontalImage: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
        verticalImage: 'https://moyashi-japan.com/cdn/shop/files/71eCz6ESqPL._SL1481.jpg?v=1736639005',
        type: 'HD Vietsub',
      ),
      MovieItem(
        name: 'Isshou Senkin',
        horizontalImage: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
        verticalImage: 'https://i.ebayimg.com/images/g/DMkAAOSwBZxl-SQ4/s-l1200.jpg',
        type: 'HD Vietsub',
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Body content
          RefreshIndicator(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(top: 0),
              controller: _scrollController,
              children: [
                MovieCarousel(items: items),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Có lẽ bạn sẽ thích',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return MovieCard(item: items[index]);
                          },
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
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return MovieCard(item: items[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onRefresh: () async {
              await Future<void>.delayed(const Duration(seconds: 1));
            },
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
                child: Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle search tap
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
          ),
        ],
      ),
    );
  }
}
