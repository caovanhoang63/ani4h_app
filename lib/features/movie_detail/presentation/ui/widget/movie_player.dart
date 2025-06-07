import 'dart:async';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePlayer extends ConsumerStatefulWidget {
  final String videoUrl;

  const MoviePlayer({super.key, required this.videoUrl});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends ConsumerState<MoviePlayer> {
  late BetterPlayerController _betterPlayerController;

  bool _controlsVisible = true; // State to manage control visibility
  Timer? _hideControlsTimer; // Timer to hide controls after inactivity
  bool _isMuted = false; // State for volume mute/unmute
  double _currentVolume = 1.0; // Store the last non-zero volume

  // States for player progress and duration
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false; // State for play/pause button icon
  bool _isLoading = true; // State for loading indicator

  // States for the animated seek overlays opacity
  double _leftSeekOverlayOpacity = 0.0;
  double _rightSeekOverlayOpacity = 0.0;

  // Timer for hiding the seek indicator
  Timer? _hideSeekOverlayTimer;

  // Sample static list of caption options
  final List<String> _captionOptions = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Portuguese',
    'Russian',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
    'Hindi',
  ];

  // State to hold the currently selected caption (placeholder)
  String? _selectedCaption = 'None';

  // Sample static list of playback speed options (value and display text)
  final List<Map<String, dynamic>> _playbackSpeedOptions = [
    {'value': 0.25, 'text': '0.25x'},
    {'value': 0.5, 'text': '0.5x'},
    {'value': 0.75, 'text': '0.75x'},
    {'value': 1.0, 'text': 'Normal'},
    {'value': 1.25, 'text': '1.25x'},
    {'value': 1.5, 'text': '1.5x'},
    {'value': 1.75, 'text': '1.75x'},
    {'value': 2.0, 'text': '2.0x'},
  ];

  // State to hold the currently selected playback speed
  double _selectedPlaybackSpeed = 1.0; // Default to Normal speed

  // State to hold the currently selected quality (index of the track)
  // We'll use -1 to represent 'Auto'
  int _selectedQualityIndex = -1;

  // List to hold available quality options (populated from player)
  List<BetterPlayerAsmsTrack> _qualityOptions = [];

  @override
  void initState() {
    super.initState();

    // Use the provided videoUrl if available, otherwise use the default
    final String videoUrl = widget.videoUrl;


    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
      videoFormat: BetterPlayerVideoFormat.hls,
    );

    // Use the default configuration (with built-in controls)
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        // Disable built-in controls to use custom ones
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
          showControlsOnInitialize: false,
        ),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );

    // Listen to player events to update UI states
    _betterPlayerController.addEventsListener(_onPlayerEvent);

    // Initialize timer to hide controls
    _startHideControlsTimer();
  }

  // Start the timer to hide controls
  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel(); // Cancel existing timer
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      // Only hide controls if they are currently visible and the player is playing
      if (_controlsVisible && _isPlaying) {
        setState(() {
          _controlsVisible = false;
        });
      }
    });
  }

  // Listener for player events
  void _onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.play) {
      setState(() {
        _isPlaying = true;
        _isLoading = false; // Not loading when playing
      });
      _startHideControlsTimer(); // Restart timer on interaction
    } else if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
      setState(() {
        _isPlaying = false;
        _isLoading = false; // Not loading when paused
      });
      _hideControlsTimer?.cancel(); // Keep controls visible when paused
    } else if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      setState(() {
        _totalDuration =
            _betterPlayerController.videoPlayerController!.value.duration ??
                Duration.zero;
        // Populate quality options after initialization
        _qualityOptions = _betterPlayerController.betterPlayerAsmsTracks;

        // Find the index of the initial playing track
        final initialTrack = _betterPlayerController.betterPlayerAsmsTrack;
        if (initialTrack != null) {
          _selectedQualityIndex = _qualityOptions.indexWhere(
                (track) =>
            track.height == initialTrack.height &&
                track.width == initialTrack.width &&
                track.bitrate == initialTrack.bitrate,
          );
          // If initial track not found in the list, default to Auto display
          if (_selectedQualityIndex == -1 && initialTrack.height == 0) {
            // If the initial track has height 0 and wasn't found,
            // it's likely the auto track, so we'll still display Auto.
            // We'll keep _selectedQualityIndex as -1 for display purposes
            // when the height 0 track is selected.
          } else if (_selectedQualityIndex == -1) {
            // If the initial track is not height 0 and not found,
            // set index to -2 to indicate an unknown quality.
            _selectedQualityIndex = -2;
          }
        } else {
          // If initialTrack is null, it implies auto is selected by default
          _selectedQualityIndex = -1;
        }
      });
      _isLoading = false; // Not loading after initialization
    } else if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      setState(() {
        _currentPosition =
            _betterPlayerController.videoPlayerController!.value.position;
      });
    } else if (event.betterPlayerEventType == BetterPlayerEventType.changedTrack) {
      // Handle explicit track changes (user selection or automatic adaptation)
      final currentTrack = _betterPlayerController.betterPlayerAsmsTrack;
      if (currentTrack != null) {
        final newIndex = _qualityOptions.indexWhere(
              (track) =>
          track.height == currentTrack.height &&
              track.width == currentTrack.width &&
              track.bitrate == currentTrack.bitrate,
        );
        if (newIndex != -1 && newIndex != _selectedQualityIndex) {
          setState(() {
            _selectedQualityIndex = newIndex;
          });
          final qualityText = currentTrack.height != null && currentTrack.width != null
              ? "${currentTrack.height}p (${currentTrack.width}x${currentTrack.height})"
              : currentTrack.bitrate != null
              ? "${(currentTrack.bitrate! / 1000).toStringAsFixed(0)} kbps"
              : 'Unknown Quality';
          print('Quality changed to: $qualityText (Index: $newIndex)');
        } else if (newIndex == -1 && _selectedQualityIndex != -1 && currentTrack.height == 0) {
          // Handle transition back to auto if the height 0 track is selected
          setState(() {
            _selectedQualityIndex = -1;
          });
          print('Quality changed to: Auto');
        }
      } else if (_selectedQualityIndex != -1) {
        // Handle transition back to auto if currentTrack becomes null (fallback)
        setState(() {
          _selectedQualityIndex = -1;
        });
        print('Quality changed to: Auto (via null track)');
      }

    } else if (event.betterPlayerEventType == BetterPlayerEventType.bufferingStart) {
      setState(() {
        _isLoading = true; // Show loading indicator when buffering starts
      });
    } else if (event.betterPlayerEventType == BetterPlayerEventType.bufferingEnd) {
      setState(() {
        _isLoading = false; // Hide loading indicator when buffering ends
      });
      // You can listen to other events like finished, error, etc.
    }
  }

  // Toggle controls visibility and restart timer if showing
  void _toggleControlsVisibility() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
    // If controls are now visible, start the hide timer
    if (_controlsVisible) {
      _startHideControlsTimer();
    } else {
      // If controls are hidden by tap, cancel the timer
      _hideControlsTimer?.cancel();
    }
  }

  // Show the seek overlay briefly
  void _showSeekOverlay({required bool isForward}) {
    _hideSeekOverlayTimer?.cancel(); // Cancel any existing timer

    setState(() {
      if (isForward) {
        _rightSeekOverlayOpacity = 0.5; // Set opacity for the right overlay
        _leftSeekOverlayOpacity = 0.0; // Ensure left is hidden
      } else {
        _leftSeekOverlayOpacity = 0.5; // Set opacity for the left overlay
        _rightSeekOverlayOpacity = 0.0; // Ensure right is hidden
      }
    });

    // Start a new timer to hide the overlay after a short duration
    _hideSeekOverlayTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _leftSeekOverlayOpacity = 0.0;
        _rightSeekOverlayOpacity = 0.0;
      });
    });
  }

  // Toggle play/pause
  void _togglePlayPause() {
    if (_betterPlayerController.isPlaying() == true) {
      _betterPlayerController.pause();
    } else {
      _betterPlayerController.play();
    }
  }

  // Seek backward by 10 seconds
  void _seekBackward() {
    final newPosition = _currentPosition - const Duration(seconds: 10);
    _betterPlayerController.seekTo(
        newPosition.isNegative ? Duration.zero : newPosition);
    _showSeekOverlay(isForward: false);
  }

  // Seek forward by 10 seconds
  void _seekForward() {
    final newPosition = _currentPosition + const Duration(seconds: 10);
    _betterPlayerController.seekTo(
        newPosition > _totalDuration ? _totalDuration : newPosition);
    _showSeekOverlay(isForward: true);
  }

  // Toggle mute/unmute
  void _toggleMute() {
    if (_isMuted) {
      _betterPlayerController.setVolume(
          _currentVolume); // Restore previous volume
    } else {
      _currentVolume = _betterPlayerController.videoPlayerController!.value
          .volume; // Store current volume
      _betterPlayerController.setVolume(0.0); // Mute
    }
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  // Format duration to HH:MM:SS or MM:SS
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "$hours:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }

  // Show the quality options BottomSheet
  void _showQualityOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6, // Limit to 60% of screen height
          ),
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Use minimum size for the column
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quality',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(
                          Icons.keyboard_arrow_down, color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator
              // "Auto" option
              InkWell(
                onTap: () {
                  // Find the track with height 0 (representing Auto)
                  final autoTrackIndex = _qualityOptions.indexWhere((track) => track.height == 0);
                  if (autoTrackIndex != -1) {
                    setState(() {
                      _selectedQualityIndex = autoTrackIndex; // Set selected index to the auto track's index
                    });
                    _betterPlayerController.setTrack(_qualityOptions[autoTrackIndex]); // Set the auto track
                  } else {
                    setState(() {
                      _selectedQualityIndex = -1; // Revert to -1 for display
                    });
                    // _betterPlayerController.setTrack(null);
                  }

                  Navigator.pop(context); // Close this bottom sheet
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      // Check icon if "Auto" is selected
                      Icon(
                        _selectedQualityIndex != -1 && _qualityOptions.isNotEmpty && _selectedQualityIndex < _qualityOptions.length && _qualityOptions[_selectedQualityIndex].height == 0
                            ? Icons.check
                            : (_selectedQualityIndex == -1 ? Icons.check : null), // Also check for -1 if auto track not found with height 0
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Auto',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator
              // List of available quality options
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: _qualityOptions.length,
                itemBuilder: (context, index) {
                  final quality = _qualityOptions[index];
                  // Skip the track with height 0 here, as it's handled by the "Auto" option above
                  if (quality.height == 0) {
                    return const SizedBox.shrink(); // Hide the duplicate "Auto" entry
                  }
                  // Determine display text (e.g., "720p", "1920x1080", "1500 kbps")
                  final qualityText = quality.height != null &&
                      quality.width != null
                      ? "${quality.height}p (${quality.width}x${quality
                      .height})"
                      : quality.bitrate != null
                      ? "${(quality.bitrate! / 1000).toStringAsFixed(0)} kbps"
                      : 'Unknown Quality';
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedQualityIndex = index; // Update selected quality index
                      });
                      _betterPlayerController.setTrack(quality); // Set specific quality
                      Navigator.pop(context); // Close this bottom sheet
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          // Check icon if this quality is selected
                          Icon(
                            _selectedQualityIndex == index
                                ? Icons.check
                                : null,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            qualityText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Show the playback speed options BottomSheet
  void _showPlaybackSpeedOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Playback speed',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(
                          Icons.keyboard_arrow_down, color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator
              // List of playback speed options
              Expanded( // Wrap ListView.builder in Expanded
                child: ListView.builder(
                  // Removed shrinkWrap: true and physics: const NeverScrollableScrollPhysics()
                  itemCount: _playbackSpeedOptions.length,
                  itemBuilder: (context, index) {
                    final option = _playbackSpeedOptions[index];
                    final value = option['value'] as double;
                    final text = option['text'] as String;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPlaybackSpeed =
                              value; // Update selected speed state
                        });
                        _betterPlayerController.setSpeed(
                            value); // Set playback speed
                        Navigator.pop(context); // Close this bottom sheet
                        // Optionally, close the main options bottom sheet as well:
                        // Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            // Check icon if this speed is selected
                            Icon(
                              _selectedPlaybackSpeed == value
                                  ? Icons.check
                                  : null,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              text,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Show the captions options BottomSheet
  void _showCaptionsOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Captions',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(
                          Icons.keyboard_arrow_down, color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator

              // "None" option
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedCaption =
                    'None'; // Update selected caption state
                  });
                  Navigator.pop(context); // Close this bottom sheet
                  // Optionally, close the main options bottom sheet as well:
                  // Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      // Check icon if "None" is selected
                      Icon(
                        _selectedCaption == 'None' ? Icons.check : null,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'None',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator

              // List of sample caption options
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery
                      .of(context)
                      .size
                      .height * 0.4,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: const ClampingScrollPhysics(),
                  itemCount: _captionOptions.length,
                  itemBuilder: (context, index) {
                    final caption = _captionOptions[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCaption =
                              caption; // Update selected caption state
                        });
                        Navigator.pop(context); // Close this bottom sheet
                        // Optionally, close the main options bottom sheet as well:
                        // Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            // Check icon if this caption is selected
                            Icon(
                              _selectedCaption == caption
                                  ? Icons.check
                                  : null,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              caption,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // Show the options BottomSheet with styled content
  void _showOptionsBottomSheet() {
    // Ensure the controls are visible when the BottomSheet is shown
    if (!_controlsVisible) {
      _toggleControlsVisibility();
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // Make background transparent to show rounded corners
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black, // Semi-transparent background
            borderRadius: BorderRadius.only( // Add rounded top corners
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content vertically
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Options', // Title
                      style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    // Close button for the bottom sheet
                    IconButton(
                      icon: const Icon(
                          Icons.keyboard_arrow_down, color: Colors.white70),
                      onPressed: () =>
                          Navigator.pop(context), // Close the bottom sheet
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator

              // Quality option
              InkWell(
                onTap: () {
                  Navigator.pop(
                      context); // Close the bottom sheet after selection
                  _showQualityOptionsBottomSheet();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  // Increased vertical padding
                  child: Row(
                    children: [
                      const Icon(
                          Icons.settings, color: Colors.white70, size: 20),
                      // Icon
                      const SizedBox(width: 16),
                      // Spacing
                      const Text('Quality', style: TextStyle(color: Colors
                          .white, fontSize: 16)),
                      const Spacer(),
                      // Pushes the next elements to the right
                      // Display the selected quality text
                      Text(
                        _selectedQualityIndex != -1 && _qualityOptions.isNotEmpty && _selectedQualityIndex < _qualityOptions.length
                            ? (_qualityOptions[_selectedQualityIndex].height == 0
                            ? 'Auto' // Display Auto if height is 0
                            : (_qualityOptions[_selectedQualityIndex].height != null
                            ? "${_qualityOptions[_selectedQualityIndex].height}p"
                            : "${(_qualityOptions[_selectedQualityIndex].bitrate! / 1000).toStringAsFixed(0)} kbps"))
                            : (_selectedQualityIndex == -1 ? 'Auto' : 'Unknown'), // Default to Auto or Unknown
                        style: const TextStyle(color: Colors.white70,
                            fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      // Spacing
                      const Icon(
                          Icons.arrow_forward_ios, color: Colors.white54,
                          size: 16),
                      // Arrow icon
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator

              // Playback Speed option
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showPlaybackSpeedOptionsBottomSheet();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  // Increased vertical padding
                  child: Row(
                    children: [
                      const Icon(
                          Icons.speed, color: Colors.white70, size: 20),
                      // Icon
                      const SizedBox(width: 16),
                      // Spacing
                      const Text('Playback Speed', style: TextStyle(
                          color: Colors.white, fontSize: 16)),
                      Spacer(),
                      // Pushes the next elements to the right
                      // Display the selected playback speed text
                      Text(
                        _playbackSpeedOptions.firstWhere(
                              (option) =>
                          option['value'] == _selectedPlaybackSpeed,
                          orElse: () =>
                          {
                            'text': 'Normal'
                          }, // Default text if speed not found (shouldn't happen with defined list)
                        )['text'] as String,
                        style: const TextStyle(color: Colors.white70,
                            fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      // Spacing
                      const Icon(
                          Icons.arrow_forward_ios, color: Colors.white54,
                          size: 16),
                      // Arrow icon
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator

              // Captions option
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showCaptionsOptionsBottomSheet();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  // Increased vertical padding
                  child: Row(
                    children: [
                      const Icon(Icons.closed_caption, color: Colors.white70,
                          size: 20), // Icon
                      const SizedBox(width: 16), // Spacing
                      const Text('Captions', style: TextStyle(color: Colors
                          .white, fontSize: 16)),
                      const Spacer(), // Pushes the next elements to the right
                      Text(_selectedCaption ?? 'Unavailable',
                          style: const TextStyle(color: Colors.white70,
                              fontSize: 16)),
                      const SizedBox(width: 8), // Spacing
                      const Icon(
                          Icons.arrow_forward_ios, color: Colors.white54,
                          size: 16), // Arrow icon
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white30, height: 1), // Separator
            ],
          ),
        );
      },
    );
  }

  // Toggle fullscreen (basic implementation placeholder)
  void _toggleFullscreen() {
    // Better Player Plus has built-in fullscreen handling
    _betterPlayerController.toggleFullScreen();
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel(); // Cancel timer
    _hideSeekOverlayTimer?.cancel(); // Cancel seek overlay timer
    _betterPlayerController.removeEventsListener(
        _onPlayerEvent); // Remove listener
    _betterPlayerController.dispose(); // Dispose player controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControlsVisibility,
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
          // --- Custom Controls Overlay ---
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Stack( // Stack to layer control elements
                children: [
                  // Transparent overlay to capture taps and gestures
                  Positioned.fill(
                    child: GestureDetector(
                      onDoubleTap: _togglePlayPause,
                      // Double tap anywhere to play/pause
                      child: Row( // Row to define left and right double-tap areas
                        children: [
                          // Left double-tap area for seeking backward
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                                onDoubleTap: _seekBackward,
                                behavior: HitTestBehavior.translucent,
                                // Ensure taps are captured
                                child: AnimatedOpacity(
                                  opacity: _leftSeekOverlayOpacity,
                                  duration: const Duration(milliseconds: 200),
                                  // Fade in/out duration
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.black.withOpacity(0.5),
                                          Colors.transparent
                                        ],
                                      ),
                                    ),
                                    child: const Center( // Center the icon within the overlay
                                      child: Icon(
                                        Icons.replay_10, // Backward seek icon
                                        color: Colors.white,
                                        size: 64, // Adjust size as needed
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                          // Middle area (single tap toggles controls, double tap toggles play/pause)
                          Expanded(
                            flex: 1,
                            child: Container(color: Colors
                                .transparent), // Transparent container
                          ),
                          // Right double-tap area for seeking forward
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                                onDoubleTap: _seekForward,
                                behavior: HitTestBehavior.translucent,
                                child: AnimatedOpacity(
                                  opacity: _rightSeekOverlayOpacity,
                                  duration: const Duration(milliseconds: 200),
                                  // Fade in/out duration
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.5)
                                        ],
                                      ),
                                    ),
                                    child: const Center( // Center the icon within the overlay
                                      child: Icon(
                                        Icons.forward_10, // Forward seek icon
                                        color: Colors.white,
                                        size: 64, // Adjust size as needed
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Top Controls
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      // Optional: Add a gradient background for better visibility
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black54, Colors.transparent],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // Align to the right
                        children: [
                          // More Options Button
                          InkWell(
                            onTap: _showOptionsBottomSheet,
                            // Toggle side menu
                            child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 20
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Floating Play/Pause Button (Middle)
                  Align(
                    alignment: Alignment.center,
                    child: IgnorePointer( // Ignore pointer events when controls are hidden
                      ignoring: !_controlsVisible,
                      child: AnimatedOpacity(
                        opacity: _controlsVisible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: GestureDetector(
                          onTap: _togglePlayPause, // Tap to play/pause
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              // Semi-transparent background
                              shape: BoxShape.circle,
                            ),
                            // Conditionally show loading indicator or play/pause icon
                            child: _isLoading
                                ? const SizedBox( // Use SizedBox to give CircularProgressIndicator a size
                              width: 48, // Match icon size
                              height: 48, // Match icon size
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white), // White color
                                strokeWidth: 4, // Adjust thickness
                              ),
                            )
                                : Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 48, // Large icon size
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  // Bottom Controls
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      // Optional: Add a gradient background for better visibility
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black54, Colors.transparent],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // Wrap content vertically
                        children: [
                          // Timer and Slider
                          Row(
                            children: [
                              Text(
                                _formatDuration(_currentPosition),
                                // Current time
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SliderTheme( // Customize slider appearance
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.red,
                                    // Active part color
                                    inactiveTrackColor: Colors.white30,
                                    // Inactive part color
                                    thumbColor: Colors.red,
                                    // Thumb color
                                    overlayColor: Colors.red.withOpacity(0.2),
                                    // Overlay color on press
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6.0),
                                    // Thumb size
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 12.0), // Overlay size
                                  ),
                                  child: Slider(
                                    value: _currentPosition.inSeconds
                                        .toDouble(),
                                    max: _totalDuration.inSeconds.toDouble(),
                                    onChanged: (value) {
                                      // Update UI while sliding (optional, can be heavy)
                                      setState(() {
                                        _currentPosition =
                                            Duration(seconds: value.toInt());
                                      });
                                    },
                                    onChangeEnd: (value) {
                                      // Seek to the new position when sliding ends
                                      _betterPlayerController.seekTo(
                                          Duration(seconds: value.toInt()));
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _formatDuration(_totalDuration),
                                // Total duration
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Space between slider and button row

                          // Button Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left side buttons
                              Row(
                                spacing: 0,
                                children: [
                                  // Pause/Play Button
                                  InkWell(
                                    onTap: _togglePlayPause,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Icon(
                                        _isPlaying ? Icons.pause : Icons
                                            .play_arrow,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  // Back 10 Seconds Button
                                  InkWell(
                                    onTap: _seekBackward,
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Icon(
                                        Icons.replay_10, color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  // Forward 10 Seconds Button
                                  InkWell(
                                    onTap: _seekForward,
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Icon(
                                        Icons.forward_10, color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  // Volume Button (Toggle Mute)
                                  // InkWell(
                                  //   onTap: _toggleMute,
                                  //   child: Padding(
                                  //     padding: EdgeInsets.symmetric(horizontal: 4),
                                  //     child: Icon(
                                  //       _isMuted ? Icons.volume_off : Icons.volume_up,
                                  //       color: Colors.white,
                                  //       size: 20,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Volume Slider (Basic - needs more complex state management for value)
                                  // This is a placeholder for the UI element
                                  // SizedBox(
                                  //   width: 70, // Fixed width for the volume slider
                                  //   child: SliderTheme(
                                  //     data: SliderTheme.of(context).copyWith(
                                  //       activeTrackColor: Colors.white,
                                  //       inactiveTrackColor: Colors.white30,
                                  //       thumbColor: Colors.white,
                                  //       overlayColor: Colors.white.withOpacity(0.2),
                                  //       overlayShape: const RoundSliderOverlayShape(overlayRadius: 10.0),
                                  //       thumbShape: SliderComponentShape.noThumb,
                                  //     ),
                                  //     child: Slider(
                                  //       value: _isMuted ? 0.0 : _betterPlayerController.videoPlayerController!.value.volume, // Reflect mute state
                                  //       min: 0.0,
                                  //       max: 1.0,
                                  //       onChanged: (value) {
                                  //         _betterPlayerController.setVolume(value);
                                  //         setState(() {
                                  //           _isMuted = value == 0; // Update mute state based on slider value
                                  //           if (value > 0) _currentVolume = value; // Store non-zero volume
                                  //         });
                                  //         _showControls(); // Show controls on interaction
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),

                              // Right side buttons (Wrapped in Expanded)
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // Align to the end
                                  children: [
                                    // Next Episode Button (Placeholder)
                                    InkWell(
                                      onTap: () {
                                        print('Next Episode button pressed');
                                        // Add logic to load the next episode
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Icon(Icons.skip_next,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    // Small Screen Button (Placeholder - typically handled by fullscreen toggle)
                                    // InkWell(
                                    //   onTap: () {
                                    //      print('Small Screen button pressed');
                                    //   },
                                    //   child: const Padding(
                                    //     padding: EdgeInsets.symmetric(horizontal: 4),
                                    //     child: Icon(Icons.fullscreen_exit, color: Colors.white, size: 24),
                                    //   ),
                                    // ),
                                    // Fullscreen Button
                                    InkWell(
                                      onTap: _toggleFullscreen,
                                      // Use Better Player's fullscreen toggle
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Icon(Icons.fullscreen,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
