import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Comment {
  final String id;
  final String? userAvatarUrl;
  final String username;
  final String text;
  final DateTime time;

  Comment({
    required this.id,
    required this.userAvatarUrl,
    required this.username,
    required this.text,
    required this.time,
  });
}

class CommentCard extends ConsumerWidget { // Changed to ConsumerWidget
  final Comment comment;

  const CommentCard({
    super.key,
    required this.comment,
  });

  String _formatTimestamp(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${time.month}/${time.day}/${time.year}';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool hasAvatarUrl = comment.userAvatarUrl?.isNotEmpty == true;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850], // Dark background for the card
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the top
        children: [
          // User Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[700],
            backgroundImage: hasAvatarUrl
                ? NetworkImage(comment.userAvatarUrl!)
                : null,
            onBackgroundImageError: hasAvatarUrl
                ? (exception, stackTrace) {
              print('Error loading avatar for user ${comment.username}: $exception');
            }
                : null,
            child: !hasAvatarUrl
                ? const Icon(Icons.person, color: Colors.white70, size: 20)
                : null,
          ),
          const SizedBox(width: 12), // Space between avatar and text content

          // Comment Content
          Expanded( // Allow the text content to take up remaining space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text left
              children: [
                // Username and Formatted Timestamp
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.username,
                      style: const TextStyle( // Added const
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _formatTimestamp(comment.time), // Use the formatted timestamp
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4), // Space between username/timestamp and comment text

                // Comment Text
                Text(
                  comment.text,
                  style: const TextStyle( // Added const
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
