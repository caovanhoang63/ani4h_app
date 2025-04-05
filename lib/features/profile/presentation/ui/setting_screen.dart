import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings",  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
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
              title: Text("Account", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Device Management", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Language", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text("English"),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Appearance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text("Dark"),
              subtitleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Notifications", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Ani4h", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
              title: Text("Terms of Service", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.1),
            alignment: Alignment.center,
            padding: EdgeInsets.all(12)
          ),
          child: const Text("Log out", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
