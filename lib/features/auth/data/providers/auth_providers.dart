import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/phone_auth_service.dart';
import '../services/user_service.dart';

/// Phone auth service provider
final phoneAuthServiceProvider = Provider<PhoneAuthService>((ref) {
  return PhoneAuthService();
});

/// User service provider
final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

/// Current user provider
final currentUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// User model provider
final userModelProvider = FutureProvider<UserModel?>((ref) async {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return null;
  
  final userService = ref.read(userServiceProvider);
  return await userService.getUser(user.uid);
});

/// Auth state provider
final authStateProvider = StateProvider<AuthState>((ref) {
  return AuthState.initial;
});

/// Auth state enum
enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

/// Auth error provider
final authErrorProvider = StateProvider<String?>((ref) {
  return null;
});

/// Verification ID provider for OTP
final verificationIdProvider = StateProvider<String?>((ref) {
  return null;
});

/// Phone number provider
final phoneNumberProvider = StateProvider<String?>((ref) {
  return null;
});
