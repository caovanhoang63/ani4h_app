import 'package:ani4h_app/core/data/local/secure_storage/isecure_storage.dart';
import 'package:ani4h_app/core/data/local/secure_storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Key for storing auth state in secure storage
const String authStateKey = "authState";

final authStateProvider = NotifierProvider<AuthState, bool>(AuthState.new);

class AuthState extends Notifier<bool> {
  @override
  bool build() {
    // Initialize state to false, but try to load from secure storage
    _loadAuthState();
    return false;
  }

  // Load auth state from secure storage
  Future<void> _loadAuthState() async {
    try {
      final secureStorage = ref.read(secureStorageProvider);
      final storedState = await secureStorage.read(authStateKey);

      if (storedState == 'true') {
        state = true;
      }
    } catch (e) {
      print("Error loading auth state: $e");
    }
  }

  void setAuthState(bool value) {
    state = value;

    // Persist the auth state to secure storage
    try {
      final secureStorage = ref.read(secureStorageProvider);
      secureStorage.write(authStateKey, value.toString());
    } catch (e) {
      print("Error saving auth state: $e");
    }
  }
}
