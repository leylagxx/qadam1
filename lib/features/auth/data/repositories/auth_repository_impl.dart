import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<String> sendOtp(String phoneNumber) async {
    return await _remoteDataSource.sendOtp(phoneNumber);
  }

  @override
  Future<String> verifyOtp(String verificationId, String otpCode) async {
    return await _remoteDataSource.verifyOtp(verificationId, otpCode);
  }

  @override
  Future<UserEntity> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    return await _remoteDataSource.registerUser(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
  }

  @override
  Future<UserEntity> signInWithPhone(String phoneNumber, String otpCode) async {
    return await _remoteDataSource.signInWithPhone(phoneNumber, otpCode);
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return await _remoteDataSource.getCurrentUser();
  }

  @override
  Future<bool> isSignedIn() async {
    return await _remoteDataSource.isSignedIn();
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    return await _remoteDataSource.updateUser(userModel);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _remoteDataSource.deleteUser(userId);
  }
}
