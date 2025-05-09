import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/common/widget/loading_state_widget.dart';
import 'package:ani4h_app/features/favorite/presentation/controller/favorite_controller.dart';
import 'package:ani4h_app/features/favorite/presentation/ui/widget/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(favoriteControllerProvider.notifier).fetchFavorites();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yêu thích'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        toolbarHeight: 76
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer(builder: (context, ref, child) {
          final state = ref.watch(favoriteControllerProvider);

          return
              LoadingStateWidget(
                isLoading: state.isLoading,
                hasError: state.hasError,
                errorMessage: state.errorMessage,
                dataIsEmpty: state.favorites.isEmpty && !state.isLoading,
                child: ListView.builder(
                    itemCount: state.favorites.length + (state.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if(index == state.favorites.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final item = state.favorites[index];
                      return FavoriteCard(item: item);
                    }
                ),
              );
        })
      )
    );
  }
}