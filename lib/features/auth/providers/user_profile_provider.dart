import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_aya_v2/core/supabase_config.dart';
import 'package:app_aya_v2/features/auth/models/user_profile.dart';

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfile?>>((ref) {
  return UserProfileNotifier();
});

class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  UserProfileNotifier() : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profileData = await SupabaseConfig.getCurrentProfile();
      if (profileData != null) {
        state = AsyncValue.data(UserProfile.fromJson(profileData));
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      await SupabaseConfig.updateProfile(data);
      await _loadProfile(); // Recarrega o perfil após a atualização
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadProfile();
  }
} 