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
    title: 'Naruto',
    synopsis: 'Japan',
    imageUrl: 'https://photo.znews.vn/w660/Uploaded/piqbzcvo/2024_01_19/Screenshot_2024_01_19_at_21.34.40.png',
    episodeNumber: 1,
    viewCount: 1000,
    duration: 1500,
    watchedDuration: 1200,
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