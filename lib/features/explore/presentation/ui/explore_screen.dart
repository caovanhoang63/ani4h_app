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
  final List<String> categories = ["Hot nhất", "Mới nhất", "Đánh giá"];
  final List<String> genres = ["Tất cả", "Phim truyền hình", "Anime", "Phim điện ảnh", "Phim hoạt hình", "Phim lẻ"];
  final List<String> years = ["Tất cả", "2024", "2023", "2022", "2021"];
  final List<String> types = ["Tất cả", "Vip", "Miễn phi"];

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
          //   Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //           minimumSize: const Size(0, 0),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //         ),
          //         onPressed: () {
          //           context.push(favoriteRoute);
          //         },
          //         child: Text(
          //             'Favorite',
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold
          //             )
          //         )
          //     ),
          //
          //     const SizedBox(width: 8),
          //
          //     ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //           minimumSize: const Size(0, 0),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //         ),
          //         onPressed: () {
          //           context.push(historyRoute);
          //         },
          //         child: Text(
          //             'History',
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold
          //             )
          //         )
          //     ),
          //
          //     const SizedBox(width: 8),
          //
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //         minimumSize: const Size(0, 0),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //       ),
          //       onPressed: () {
          //         context.push(searchRoute);
          //       },
          //       child: Text(
          //           'Search',
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold
          //           )
          //       )
          //     ),
          //   ],
          // ),

            // List of filter

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                TagSelector(tags: categories, selecetedIndex: selectedCategory, onTagSelected: (index) {
                  setState(() {
                    selectedCategory = index;
                  });
                }),
                // Genre
                TagSelector(tags: genres, selecetedIndex: selectedGenre, onTagSelected: (index) {
                  setState(() {
                    selectedGenre = index;
                  });
                }),
                // Type
                TagSelector(tags: types, selecetedIndex: selectedType, onTagSelected: (index) {
                  setState(() {
                    selectedType = index;
                  });
                }),
                // Year
                TagSelector(tags: years, selecetedIndex: selectedYear, onTagSelected: (index) {
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