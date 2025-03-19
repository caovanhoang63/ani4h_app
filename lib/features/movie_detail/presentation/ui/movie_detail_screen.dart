import 'package:ani4h_app/features/movie_detail/presentation/controller/movie_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  String _page = '';
  String _pageSize = '';
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    _listener();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    ref.read(movieDetailControllerProvider.notifier).login(_username, _password);
                  },
                  child: Text('Login'),
                )
              ],
            ),
            const SizedBox(height: 20),
            // Page and Page Size Inputs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _page = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Page',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _pageSize = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Page Size',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(movieDetailControllerProvider.notifier).fetchUser(int.tryParse(_page) ?? 1, int.tryParse(_pageSize) ?? 10);
                  },
                  child: Text('Confirm'),
                )
              ],
            ),
            const SizedBox(height: 20),

            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: ref.watch(movieDetailControllerProvider).users.length,
                itemBuilder: (context, index) {
                  final user = ref.watch(movieDetailControllerProvider).users[index];
                  return Text(user.displayName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _listener() {
    // listen for error
    ref.listen(movieDetailControllerProvider.select((value) => value.hasError),
            (_, next) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text("Login failed"),
            ),
          );
        });
    // listen for success
    ref.listen(movieDetailControllerProvider.select((value) => value.isLoginSuccess),
            (_, next) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 5),
                  backgroundColor: Colors.green,
                  content: Text("Login success"),
                ),
              );
        });
  }
}