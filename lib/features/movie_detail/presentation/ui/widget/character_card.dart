import 'package:ani4h_app/features/movie_detail/data/dto/movie_detail_response/movie_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterCard extends ConsumerWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(character.image.url),
                radius: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      character.role ?? 'Unknown',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                )
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Voiced by:',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
          ...character.actors.take(2).map((va) =>
            Row(
              children: [
                va.image != null ?
                CircleAvatar(
                  backgroundImage: NetworkImage(va.image!.url),
                  radius: 10,
                ) : const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 10,
                ),
                const SizedBox(width: 6),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          va.name,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          va.language ?? 'Unknown',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}