import 'package:ani4h_app/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Chỉ cho phép dọc
    // DeviceOrientation.landscapeLeft, // Hoặc thêm dòng này để cho phép ngang trái
  ]).then((_) {
    runApp(
      ProviderScope(
        child: MainWidget(),
      ),
    );
  });
}