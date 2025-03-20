import 'package:ani4h_app/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login"),
      ),
      body: Column(
        children: [
          const Text("Email",textAlign: TextAlign.left,),
          TextField(
            textAlign: TextAlign.center,
          ),
          const Text("Password",textAlign: TextAlign.left,),
          TextField(
            style: TextStyle(
              color: Colors.red
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(onPressed: ()=>{
            context.push(signupRoute)
          }, child: const Text("Sign up")),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.login)),
        ],
      ),
    );
  }
}
