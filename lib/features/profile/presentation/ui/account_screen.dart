import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account",  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: ListView(
        children: const [
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Google", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Facebook", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Phone number", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text("Add your phone number"),
              subtitleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Ani4h ID", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
