import 'package:ani4h_app/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = 'Bui Huy';

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
              context.push(loginRoute);
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
                      user[0],
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  Text(
                    user,
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
              )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
