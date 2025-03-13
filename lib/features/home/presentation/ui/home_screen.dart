import 'package:ani4h_app/features/home/presentation/ui/tabs/account_tab.dart';
import 'package:ani4h_app/features/home/presentation/ui/tabs/explore_tab.dart';
import 'package:ani4h_app/features/home/presentation/ui/tabs/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TabStateNotifier for managing tab state more flexibly
class TabStateNotifier extends StateNotifier<int> {
  TabStateNotifier() : super(0);

  void selectTab(int index) {
    state = index;
  }
}

// Define the provider
final tabStateProvider = StateNotifierProvider<TabStateNotifier, int>((ref) {
  return TabStateNotifier();
});


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = [
      MainTab(),
      ExploreTab(),
      AccountTab()
    ];

    return Scaffold(
      body: IndexedStack(
        index: ref.watch(tabStateProvider),
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        currentIndex: ref.watch(tabStateProvider),
        onTap: (index) {
          ref.read(tabStateProvider.notifier).selectTab(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}