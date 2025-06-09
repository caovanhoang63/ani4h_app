import 'package:ani4h_app/core/data/local/secure_storage/secure_storage.dart';
import 'package:ani4h_app/features/profile/application/profile_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const userIdState = "userIdState";
final userIdStateProvider = NotifierProvider<UserIdState, String>(UserIdState.new);

class UserIdState extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  Future<void> gerUserIdByEmail(String email) async {
    try {
      final userId = await ref.read(profileServiceProvider).getUserIdByEmail(email);
      userId.when(
        (data) async {
          final secureStorage = ref.read(secureStorageProvider);
          await secureStorage.write(userIdState, data.userId);
          print("User ID fetched successfully: ${data.userId}");
        },
        (failure) {
          print("Error fetching user ID: ${failure.message}");
        },
      );
    } catch (e) {
      print("Error loading auth state: $e");
    }
  }

}
