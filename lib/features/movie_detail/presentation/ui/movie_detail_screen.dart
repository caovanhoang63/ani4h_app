import 'package:ani4h_app/features/movie_detail/presentation/ui/widget/movie_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            children: [
              MoviePlayer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Movie Title", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          Positioned(
            top: 50,
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ]
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}