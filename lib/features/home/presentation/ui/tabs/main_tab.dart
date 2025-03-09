import 'package:ani4h_app/features/home/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTab extends ConsumerStatefulWidget {
  const MainTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainTabState();
}

class _MainTabState extends ConsumerState<MainTab> {
  @override
  Widget build(BuildContext context) {
    final items = [
      MovieItem(
        name: 'Amagami-San Chi No Enmusubi!',
        image: 'https://s1.zerochan.net/Amagami-san.Chi.no.Enmusubi.600.4246178.jpg',
        type: 'HD Vietsub',
      ),
      MovieItem(
        name: 'Mayonaka Heart Tune',
        image: 'https://static.zerochan.net/Inohana.Rikka.full.4142078.jpg',
        type: 'HD Vietsub',
      ),
      MovieItem(
        name: 'Isshou Senkin',
        image: 'https://www.intoxianime.com/wp-content/uploads/2023/04/issho-520x245.jpg',
        type: 'HD Vietsub',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: RefreshIndicator(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return MovieCard(item: items[index]);
                  },
                ),
              )
            ],
          ),
          onRefresh: () async {
            await Future<void>.delayed(const Duration(seconds: 1));
          }
      )
    );
  }
}