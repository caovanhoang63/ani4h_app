import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ani4h_app/features/profile/application/profile_service.dart';

import '../state/profile_state.dart';

final profileControllerProvider = NotifierProvider<ProfileController, ProfileState>(ProfileController.new);

class ProfileController extends Notifier<ProfileState> {

  @override
  ProfileState build() {
    return ProfileState();
  }

  Future<void> getProfile(String id) async {
    try {
      state = state.copyWith(isLoading: true, hasError: false, errorMessage: '');

      final result = await ref.read(profileServiceProvider).getProfile(id);
      result.when(
        (profile) {
          state = state.copyWith(
            profile: profile,
            isLoading: false,
          );
          print("Profile fetched successfully: ${profile.displayName}");
        },
        (failure) {
          state = state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: failure.message,
          );
          print("Error fetching profile: ${failure.stackTrace}");
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

} 