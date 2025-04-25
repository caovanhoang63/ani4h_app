import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingStateWidget extends ConsumerWidget {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final bool dataIsEmpty;
  final Widget child;

  const LoadingStateWidget({
    super.key,
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
    required this.dataIsEmpty,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    if(isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else if (hasError) {
      return Center(
        child: Text(
          "Lỗi: $errorMessage",
          style: const TextStyle(
            color: Colors.red,
            fontSize: 18,
          ),
        ),
      );
    }
    else if (dataIsEmpty) {
      return Center(
        child: Text(
          'Không tìm thấy kết quả',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      );
    }
    else {
      return child;
    }
  }
}