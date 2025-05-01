import 'package:ani4h_app/features/history/presentation/ui/widget/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final List<HistoryItem> historyItems = [
    HistoryItem(
    id: '1',
    name: 'Naruto',
    nation: 'Japan',
    imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
    tags: ['Action', 'Adventure'],
    ),
    HistoryItem(
      id: '2',
      name: 'One Piece',
      nation: 'Japan',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    HistoryItem(
      id: '3',
      name: 'Attack on Titan',
      nation: 'Việt Nam',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
      tags: ['Action', 'Adventure'],
    ),
    HistoryItem(
      id: '4',
      name: 'My Hero Academia',
      nation: 'Trung Quốc',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    HistoryItem(
      id: '1',
      name: 'Naruto',
      nation: 'Japan',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
      tags: ['Action', 'Adventure'],
    ),
    HistoryItem(
      id: '2',
      name: 'One Piece',
      nation: 'Japan',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    HistoryItem(
      id: '3',
      name: 'Attack on Titan',
      nation: 'Việt Nam',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
      tags: ['Action', 'Adventure'],
    ),
    HistoryItem(
      id: '4',
      name: 'My Hero Academia',
      nation: 'Trung Quốc',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    HistoryItem(
      id: '1',
      name: 'Naruto',
      nation: 'Japan',
      imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
      tags: ['Action', 'Adventure'],
    ),
    HistoryItem(
      id: '2',
      name: 'One Piece',
      nation: 'Japan',
      imageUrl: 'https://vocesabianime.com/wp-content/uploads/2023/09/Mayonaka_Heart_Tune_o_substituto_de-Gotoubun_no_hanayome_1133x637.jpg',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
    HistoryItem(
      id: '3',
      name: 'Attack on Titan',
      nation: 'Việt Nam',
      imageUrl: 'https://down-vn.img.susercontent.com/file/vn-11134201-7r98o-m0b739a84kq595',
      tags: ['Action', 'Adventure'],
    ),
    HistoryItem(
      id: '4',
      name: 'My Hero Academia',
      nation: 'Trung Quốc',
      imageUrl: 'https://i0.wp.com/www.otakupt.com/wp-content/uploads/2023/04/Isshou-Senkin-manga-teaser-1.jpg?resize=696%2C433&ssl=1',
      tags: ['Action', 'Adventure', 'Fantasy'],
    ),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử'),
        centerTitle: true,
        toolbarHeight: 76,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: historyItems.length,
          itemBuilder: (context, index){
            final item = historyItems[index];
            return HistoryCard(item: item);
          },
        ),
      ),
    );
  }
}