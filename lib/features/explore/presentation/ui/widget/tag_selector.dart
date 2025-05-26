import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagSelector extends ConsumerWidget{
  final List<Map<String,dynamic>> tags;
  final int selectedIndex;
  final Function(int) onTagSelected;

  const TagSelector({
    super.key,
    required this.tags,
    required this.selectedIndex,
    required this.onTagSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16, right: 8),
      child: Row(
        children: List.generate(tags.length, (index) {
          bool isSelected = index == selectedIndex;
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: const Size(0, 0),
                  backgroundColor: isSelected ? Color(0x33FF4A22) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  onTagSelected(index);
                },
                child: Text(
                    tags[index]["name"].toString() ?? "",
                    style: TextStyle(
                        color: isSelected ? Color(0xFFFF4A22) : Colors.white,
                        fontWeight: FontWeight.bold
                    )
                )
              ),
          );
        }),
      ),
    );
  }
}