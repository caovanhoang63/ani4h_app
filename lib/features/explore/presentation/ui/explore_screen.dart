import 'dart:collection';

import 'package:ani4h_app/core/route/route_name.dart';
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
  final List<ExploreItem> exploreItems = [
    ExploreItem(
      id: '1',
      name: 'Naruto Shippuden Sasuke',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
    ),
    ExploreItem(
      id: '2',
      name: 'One Piece',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
    ),
    ExploreItem(
      id: '3',
      name: 'Attack on Titan',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
    ),
    ExploreItem(
      id: '4',
      name: 'My Hero Academia',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
    ),
    ExploreItem(
      id: '1',
      name: 'Naruto',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
    ),
    ExploreItem(
      id: '2',
      name: 'One Piece',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
    ),
    ExploreItem(
      id: '3',
      name: 'Attack on Titan',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
    ),
    ExploreItem(
      id: '4',
      name: 'My Hero Academia',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
    ),
    ExploreItem(
      id: '1',
      name: 'Naruto',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
    ),
    ExploreItem(
      id: '2',
      name: 'One Piece',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
    ),
    ExploreItem(
      id: '3',
      name: 'Attack on Titan',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
    ),
    ExploreItem(
      id: '4',
      name: 'My Hero Academia',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
    ),
    ExploreItem(
      id: '1',
      name: 'Naruto',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
    ),
    ExploreItem(
      id: '2',
      name: 'One Piece',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
    ),
    ExploreItem(
      id: '3',
      name: 'Attack on Titan',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
    ),
    ExploreItem(
      id: '4',
      name: 'My Hero Academia',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
    ),
    ExploreItem(
      id: '1',
      name: 'Naruto',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
    ),
    ExploreItem(
      id: '2',
      name: 'One Piece',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
    ),
    ExploreItem(
      id: '3',
      name: 'Attack on Titan',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
    ),
    ExploreItem(
      id: '4',
      name: 'My Hero Academia',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
    ),
  ];
  final List<Map<String,dynamic>> genres = [
    {"name": "Tất cả", "value": "all"},
    {"name": "Action", "value": "action"},
    {"name": "Adventure", "value": "adventure"},
    {"name": "Comedy", "value": "comedy"},
    {"name": "Drama", "value": "drama"},
    {"name": "Fantasy", "value": "fantasy"},
    {"name": "Horror", "value": "horror"},
    {"name": "Mystery", "value": "mystery"},
    {"name": "Romance", "value": "romance"},
    {"name": "Sci-Fi", "value": "sci-fi"},
  ];

  final List<Map<String, dynamic>> seasons = [
    {"name": "Tất cả", "value": "all"},
    {"name": "Spring", "value": "spring"},
    {"name": "Summer", "value": "summer"},
    {"name": "Fall", "value": "fall"},
    {"name": "winter", "value": "winter"},
  ];

  final List<Map<String, dynamic>> years = [
    {"name": "Tất cả", "value": "all"},
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

            //Debug area

            Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 16),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    minimumSize: const Size(0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.push(favoriteRoute);
                  },
                  child: Text(
                      'Favorite',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )
                  )
              ),

              const SizedBox(width: 8),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    minimumSize: const Size(0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.push(historyRoute);
                  },
                  child: Text(
                      'History',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )
                  )
              ),
            ],
          ),

            // List of filter

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Genre
                TagSelector(tags: genres, selectedIndex: selectedGenre, onTagSelected: (index) {
                  setState(() {
                    selectedGenre = index;
                  });
                }),
                // Type
                TagSelector(tags: seasons, selectedIndex: selectedType, onTagSelected: (index) {
                  setState(() {
                    selectedType = index;
                  });
                }),
                //Year
                TagSelector(tags: years, selectedIndex: selectedYear, onTagSelected: (index) {
                  setState(() {
                    selectedYear = index;
                  });
                }),
              ],
            ),

            //Space
            const SizedBox(height: 16),

            // result
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  childAspectRatio: 5.6/10,
                ),
                itemCount: exploreItems.length,
                itemBuilder: (context, index) {
                  return ExploreCard(item: exploreItems[index]);
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}