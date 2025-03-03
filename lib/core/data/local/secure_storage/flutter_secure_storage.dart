import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return FlutterSecureStorage(
    aOptions: const AndroidOptions(
      encryptedSharedPreferences: true
    ),
    iOptions: const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock
    ),
    lOptions: const LinuxOptions(

    )
  );
});
