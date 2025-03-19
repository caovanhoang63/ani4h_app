import 'package:ani4h_app/features/profile/presentation/ui/profile_screen.dart';
import 'package:ani4h_app/features/explore/presentation/ui/explore_screen.dart';
import 'package:ani4h_app/features/home/presentation/ui/home_screen.dart';
import 'package:ani4h_app/features/main/presentation/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// // TabStateNotifier for managing tab state more flexibly
// class TabStateNotifier extends StateNotifier<int> {
//   TabStateNotifier() : super(0);
//
//   void selectTab(int index) {
//     state = index;
//   }
// }
//
// // Define the provider
// final tabStateProvider = StateNotifierProvider<TabStateNotifier, int>((ref) {
//   return TabStateNotifier();
// });


class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = [
      HomeScreen(),
      ExploreScreen(),
      ProfileScreen()
    ];

    return Scaffold(
      body: IndexedStack(
        index: ref.watch(mainControllerProvider.select((value) => value.currentTab)),
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        currentIndex: ref.watch(mainControllerProvider.select((value) => value.currentTab)),
        onTap: (index) {
          ref.read(mainControllerProvider.notifier.select((value) => value.selectTab(index)));
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