import 'package:ani4h_app/core/data/local/secure_storage/flutter_secure_storage.dart';
import 'package:ani4h_app/core/data/local/secure_storage/isecure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<ISecureStorage>((ref) {
  final secureStorage = ref.watch(flutterSecureStorageProvider);
  return SecureStorage(secureStorage);
});

final class SecureStorage implements ISecureStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorage(this._secureStorage);

  @override
  Future<void> delete(String key) async {
    print("SecureStorage: Deleting value for key: $key");
    try {
       await _secureStorage.delete(key: key);
       print("SecureStorage: Successfully deleted value for key: $key");
    } catch (e) {
      print("SecureStorage: Error deleting value for key: $key, error: $e");
      rethrow;
    }
  }

  @override
  Future<String?> read(String key) async {
    print("SecureStorage: Reading value for key: $key");
    try {
      final value = await _secureStorage.read(key: key);
      print("SecureStorage: Value for key $key: ${value != null ? 'not null' : 'null'}, ${value?.isNotEmpty == true ? 'not empty' : 'empty'}");
      return value;
    } catch (e) {
      print("SecureStorage: Error reading value for key: $key, error: $e");
      rethrow;
    }
  }

  @override
  Future<void> write(String key, String value) async {
    print("SecureStorage: Writing value for key: $key, value length: ${value.length}");
    try {
      await _secureStorage.write(key: key, value: value);
      print("SecureStorage: Successfully wrote value for key: $key");
    } catch (e) {
      print("SecureStorage: Error writing value for key: $key, error: $e");
      rethrow;
    }
  }

}
