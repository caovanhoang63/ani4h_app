import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/dto/movie_response/movie_response.dart';

class MovieTag extends ConsumerWidget {
  final Genre tag;

  const MovieTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag.name,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 8
        ),
      ),
    );
  }
}