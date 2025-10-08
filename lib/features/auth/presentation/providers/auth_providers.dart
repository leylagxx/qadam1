import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/register_user_usecase.dart';

/// Firebase Auth provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Firebase Firestore provider
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Auth remote data source provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final firestore = ref.watch(firestoreProvider);
  
  return AuthRemoteDataSourceImpl(
    firebaseAuth: firebaseAuth,
    firestore: firestore,
  );
});

/// Auth repository provider
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  
  return AuthRepositoryImpl(remoteDataSource);
});

/// Send OTP use case provider
final sendOtpUseCaseProvider = Provider<SendOtpUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  
  return SendOtpUseCase(authRepository);
});

/// Verify OTP use case provider
final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  
  return VerifyOtpUseCase(authRepository);
});

/// Register user use case provider
final registerUserUseCaseProvider = Provider<RegisterUserUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  
  return RegisterUserUseCase(authRepository);
});
