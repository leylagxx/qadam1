import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/register_user_usecase.dart';
import '../providers/auth_providers.dart';

/// Authentication state
class AuthState {
  final UserEntity? user;
  final bool isLoading;
  final String? error;
  final String? verificationId;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.verificationId,
  });

  /// Create initial state
  const AuthState.initial() : this();

  /// Create loading state
  const AuthState.loading() : this(isLoading: true);

  /// Create success state
  const AuthState.success(UserEntity user) : this(user: user);

  /// Create error state
  const AuthState.error(String error) : this(error: error);

  /// Create verification state
  const AuthState.verification(String verificationId) : this(verificationId: verificationId);

  /// Copy with new values
  AuthState copyWith({
    UserEntity? user,
    bool? isLoading,
    String? error,
    String? verificationId,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.user == user &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.verificationId == verificationId;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        verificationId.hashCode;
  }
}

/// Authentication notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final RegisterUserUseCase _registerUserUseCase;

  AuthNotifier({
    required SendOtpUseCase sendOtpUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required RegisterUserUseCase registerUserUseCase,
  }) : _sendOtpUseCase = sendOtpUseCase,
       _verifyOtpUseCase = verifyOtpUseCase,
       _registerUserUseCase = registerUserUseCase,
       super(const AuthState.initial());

  /// Send OTP to phone number
  Future<void> sendOtp(String phoneNumber) async {
    state = const AuthState.loading();
    
    try {
      final verificationId = await _sendOtpUseCase.call(phoneNumber);
      state = AuthState.verification(verificationId);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Verify OTP code
  Future<void> verifyOtp(String otpCode) async {
    if (state.verificationId == null) {
      state = const AuthState.error('No verification ID available');
      return;
    }

    state = const AuthState.loading();
    
    try {
      final userId = await _verifyOtpUseCase.call(state.verificationId!, otpCode);
      // For now, we'll create a mock user
      // In a real implementation, you would fetch the user from the repository
      final user = UserEntity(
        id: userId,
        fullName: 'User',
        email: 'user@example.com',
        phoneNumber: '+77777777777',
        isPhoneVerified: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Register new user
  Future<void> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    state = const AuthState.loading();
    
    try {
      final user = await _registerUserUseCase.call(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Reset state
  void reset() {
    state = const AuthState.initial();
  }
}

/// Auth notifier provider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final sendOtpUseCase = ref.watch(sendOtpUseCaseProvider);
  final verifyOtpUseCase = ref.watch(verifyOtpUseCaseProvider);
  final registerUserUseCase = ref.watch(registerUserUseCaseProvider);

  return AuthNotifier(
    sendOtpUseCase: sendOtpUseCase,
    verifyOtpUseCase: verifyOtpUseCase,
    registerUserUseCase: registerUserUseCase,
  );
});
