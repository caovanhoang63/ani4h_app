import 'package:ani4h_app/core/data/local/secure_storage/secure_storage.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/profile/presentation/controller/logout_controller.dart';
import 'package:ani4h_app/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/provider/user_id_state/user_id_state_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  @override
  initState() {
    super.initState();
    Future.microtask(() async {
      final secureStorage = ref.read(secureStorageProvider);
      final userId = await secureStorage.read(userIdState);
      print("User ID profile screen: $userId");
      if(userId == null || userId.isEmpty) {
        context.push(loginRoute);
        return;
      }
      ref.read(profileControllerProvider.notifier).getProfile(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileControllerProvider);
    print("User profile screen: ${user.profile}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actionsPadding: const EdgeInsets.all(12),
        actions: [
          Container(
            decoration: BoxDecoration(
              color:  Color.fromRGBO(255, 255, 255, 0.1),
              shape: BoxShape.circle,
            ),
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.qr_code, color: Colors.white),
              iconSize: 24,
              onPressed: () {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color:  Color.fromRGBO(255, 255, 255, 0.1),
              shape: BoxShape.circle,
            ),
            width: 48,
            height: 48,
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              iconSize: 24,
              onPressed: () {},
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          GestureDetector(
            onTap: () {
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(16,20,16,20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[700],
                    child: Text(
                      user.isLoading
                          ? "Loading..."
                          : user.profile?.displayName?.substring(0, 1) ?? "U",
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  Text(
                    user.isLoading
                    ? "Loading..."
                        : user.profile?.displayName ?? "User",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16,0,16,0),
                title: const Text("History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                },
              ),
                ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16,0,16,0),
                title: const Text("Favorite", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                },
              ),
                ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16,0,16,0),
                title: const Text("Help & Report", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                },
              ),
                ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16,0,16,0),
                title: const Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  context.pushNamed(settingRoute);
                },
              )],
            ),

          ),

        ],

      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Get the logout controller and call logout
            final logoutController = ref.read(logoutControllerProvider);
            logoutController.logout(GoRouter.of(context));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.1),
              alignment: Alignment.center,
              padding: EdgeInsets.all(12)
          ),
          child: const Text("Log out", style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)),
        ),
      ),
    );

  }
}
