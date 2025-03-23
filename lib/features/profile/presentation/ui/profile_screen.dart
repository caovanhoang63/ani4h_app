import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          Container(
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

          Expanded(
            child: ListView(
              children: const [
                AccountOption(title: 'Lịch sử'),
                AccountOption(title: 'Yêu thích'),
                AccountOption(title: 'Trợ giúp và phản hồi'),
                AccountOption(title: 'Cài đặt'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountOption extends StatelessWidget {
  final String title;

  const AccountOption({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16,0,16,0),
      title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: () {},
    );
  }
}