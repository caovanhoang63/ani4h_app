import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePlayer extends ConsumerStatefulWidget {
  const MoviePlayer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends ConsumerState<MoviePlayer> {
  static const movieUrl = "https://d2oh79ptmlqizl.cloudfront.net/output.webm/master.m3u8";

  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      movieUrl,
      videoFormat: BetterPlayerVideoFormat.hls,
    );

    // Use the default configuration (with built-in controls)
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          // Video Player
          SizedBox(
            width: double.infinity,
            height: 225,
            child: BetterPlayer(
              controller: _betterPlayerController,
            ),
          ),
        ],
      ),
    );
  }
}