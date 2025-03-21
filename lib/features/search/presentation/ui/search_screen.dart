import 'package:ani4h_app/features/search/presentation/ui/widget/top_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget{
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final List<TopSearchItem> topSearchItems = [
    TopSearchItem(
      id: '1',
      name: 'Naruto',
      nation: 'Japan',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
      tags: ['Action', 'Adventure'],
    ),
    TopSearchItem(
      id: '2',
      name: 'One Piece',
      nation: 'Japan',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    TopSearchItem(
      id: '3',
      name: 'Attack on Titan',
      nation: 'Việt Nam',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
      tags: ['Action', 'Adventure'],
    ),
    TopSearchItem(
      id: '4',
      name: 'My Hero Academia',
      nation: 'Trung Quốc',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    TopSearchItem(
      id: '1',
      name: 'Naruto',
      nation: 'Japan',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
      tags: ['Action', 'Adventure'],
    ),
    TopSearchItem(
      id: '2',
      name: 'One Piece',
      nation: 'Japan',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    TopSearchItem(
      id: '3',
      name: 'Attack on Titan',
      nation: 'Việt Nam',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
      tags: ['Action', 'Adventure'],
    ),
    TopSearchItem(
      id: '4',
      name: 'My Hero Academia',
      nation: 'Trung Quốc',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    TopSearchItem(
      id: '1',
      name: 'Naruto',
      nation: 'Japan',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
      tags: ['Action', 'Adventure'],
    ),
    TopSearchItem(
      id: '2',
      name: 'One Piece',
      nation: 'Japan',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    TopSearchItem(
      id: '3',
      name: 'Attack on Titan',
      nation: 'Việt Nam',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
      tags: ['Action', 'Adventure'],
    ),
    TopSearchItem(
      id: '4',
      name: 'My Hero Academia',
      nation: 'Trung Quốc',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
  ];
  final String searchQuery = '';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        padding: const EdgeInsets.only(right: 16),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF121212),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextField(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Tìm kiếm',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Button Text (Cancel)
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Hủy',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
              // Search result or Top search
              Expanded(
                child: searchQuery.isEmpty
                  ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left:12),
                        child: Text(
                          'Tìm kiếm hàng đầu',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
        
                      Flexible(
                        child: Container(
                          color: Color(0xFF121212),
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: topSearchItems.length,
                            itemBuilder: (context, index) {
                              final item = topSearchItems[index];
                              return TopSearchCard(item: item);
                            },
                          ),
                          ),
                        ),
                      ),
                    ],
                  )
        
                  :
                  Container(
                    color: Color(0xFF121212),
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Search result $index'),
                        );
                      },
                    ),
                  ),
                )
              ),
            ]
        ),
      ),
    );
  }
}
