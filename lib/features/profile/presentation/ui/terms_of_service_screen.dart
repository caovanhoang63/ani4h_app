import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class TermsOfServiceScreen extends ConsumerWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Terms of Service",  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
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
            title: Text("Terms of Service", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            contentPadding:  EdgeInsets.fromLTRB(16,0,16,0),
            title: Text("Privacy Policy", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
