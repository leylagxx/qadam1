import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/firebase_config.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_typography.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/scaffold/gradient_scaffold.dart';
import 'success_modal.dart';

/// User registration screen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      _showSnackBar('Шарттармен келісу керек');
      return;
    }

    // Show final agreement modal
    _showFinalAgreementModal();
  }

  void _completeRegistration() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get current user from Firebase Auth
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        _showSnackBar('Қате: Пайдаланушы табылмады');
        return;
      }

      // Update Firebase Auth user profile
      final displayName = _nameController.text.trim();
      print('🔑 RegisterScreen: Setting displayName to: $displayName');
      await currentUser.updateDisplayName(displayName);
      print('🔑 RegisterScreen: Firebase Auth displayName updated: ${currentUser.displayName}');

      // Create user data
      final userData = {
        'uid': currentUser.uid,
        'phoneNumber': currentUser.phoneNumber,
        'displayName': displayName,
        'email': _emailController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      print('🔑 RegisterScreen: User data to save: $userData');

      // Save to Firestore
      await FirebaseConfig.firestore
          .collection('users')
          .doc(currentUser.uid)
          .set(userData);

      print('✅ User data saved to Firestore: ${currentUser.uid}');
      print('✅ User data saved with displayName: $displayName');
      
      if (mounted) {
        _showSnackBar('Тіркелу сәтті аяқталды!');
        _showSuccessModal();
      }
    } catch (e) {
      print('❌ Error saving user data: $e');
      if (mounted) {
        _showSnackBar('Қате: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showFinalAgreementModal() {
    bool isFinalAgreed = false;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Соңғы растау',
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Сіз тіркелуді аяқтауға дайынсыз ба?\n\n'
                'Тіркелу арқылы сіз біздің барлық шарттарымызға және саясатымызға толық келісесіз.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              // Checkbox for final agreement
              Row(
                children: [
                  Checkbox(
                    value: isFinalAgreed,
                    onChanged: (value) {
                      setState(() {
                        isFinalAgreed = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  Expanded(
                    child: Text(
                      'Иә, мен тіркелуді аяқтауға дайынмын',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Болдырмау',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: isFinalAgreed ? () async {
                Navigator.of(context).pop();
                await _processRegistration();
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFinalAgreed ? AppColors.primary : AppColors.textTertiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Тіркелу',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processRegistration() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigate to main app
    context.go('/');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SuccessModal(),
    );
  }

  void _showTermsModal() {
    bool isAgreed = false;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Пайдалану шарттары',
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '1. Жалпы ережелер\n\n'
                  'Бұл пайдалану шарттары Qadam қосымшасын пайдалану кезінде қолданылады.\n\n'
                  '2. Қосымшаны пайдалану\n\n'
                  'Қосымшаны тек заңды мақсаттар үшін пайдаланыңыз.\n\n'
                  '3. Пайдаланушы міндеттері\n\n'
                  'Пайдаланушы өз деректерін дұрыс және толық енгізуге міндетті.\n\n'
                  '4. Құпиялылық\n\n'
                  'Біз сіздің жеке деректеріңізді қорғаймыз және үшінші тұлғалармен бөліспейміз.\n\n'
                  '5. Жауапкершілік\n\n'
                  'Қосымшаны пайдалану кезінде туындаған кез келген залал үшін пайдаланушы жауапты.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),
                // Checkbox for agreement
                Row(
                  children: [
                    Checkbox(
                      value: isAgreed,
                      onChanged: (value) {
                        setState(() {
                          isAgreed = value ?? false;
                        });
                      },
                      activeColor: AppColors.primary,
                    ),
                    Expanded(
                      child: Text(
                        'Мен осы шарттармен келісемін',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isAgreed ? () => Navigator.of(context).pop() : null,
              child: Text(
                'Жабу',
                style: AppTypography.bodyLarge.copyWith(
                  color: isAgreed ? AppColors.primary : AppColors.textTertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPrivacyModal() {
    bool isAgreed = false;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Құпиялылық саясаты',
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '1. Деректерді жинау\n\n'
                  'Біз сізден келесі деректерді жинаймыз:\n'
                  '• Аты-жөні\n'
                  '• Электрондық пошта\n'
                  '• Телефон нөмірі\n\n'
                  '2. Деректерді пайдалану\n\n'
                  'Жиналған деректерді тек қызмет көрсету мақсатында пайдаланамыз.\n\n'
                  '3. Деректерді қорғау\n\n'
                  'Сіздің деректеріңіз қауіпсіз серверлерде сақталады.\n\n'
                  '4. Cookie файлдары\n\n'
                  'Қосымшада cookie файлдары пайдаланылуы мүмкін.\n\n'
                  '5. Деректерді өшіру\n\n'
                  'Сіз кез келген уақытта өз деректеріңізді өшіру сұрауыңызға болады.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),
                // Checkbox for agreement
                Row(
                  children: [
                    Checkbox(
                      value: isAgreed,
                      onChanged: (value) {
                        setState(() {
                          isAgreed = value ?? false;
                        });
                      },
                      activeColor: AppColors.primary,
                    ),
                    Expanded(
                      child: Text(
                        'Мен осы саясатпен келісемін',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isAgreed ? () => Navigator.of(context).pop() : null,
              child: Text(
                'Жабу',
                style: AppTypography.bodyLarge.copyWith(
                  color: isAgreed ? AppColors.primary : AppColors.textTertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.primary,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Row(
                      children: [
                        // Back button
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                context.go('/otp');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  
                  // Main content
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          
                          // Title
                          Text(
                            'Жаңа тіркеу',
                            style: AppTypography.headlineLarge.copyWith(
                              color: AppColors.black,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          
                          // Subtitle
                          Text(
                            'Жеке деректеріңізді енгізіңіз',
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 32.h),
                
                          // Name field
                          _buildTextField(
                            controller: _nameController,
                            label: 'Аты-жөні',
                            hint: 'Атыңызды енгізіңіз',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Аты-жөнін енгізіңіз';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          
                          // Email field
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'Почтаңызды енгізіңіз',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email енгізіңіз';
                              }
                              if (!value.contains('@')) {
                                return 'Дұрыс email енгізіңіз';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          
                          // Password field
                          _buildTextField(
                            controller: _passwordController,
                            label: 'Құпиясөз',
                            hint: 'Құпиясөзіңізді енгізіңіз',
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.textTertiary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Құпия сөзді енгізіңіз';
                              }
                              if (value.length < 6) {
                                return 'Құпия сөз кемінде 6 символ болуы керек';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),
                          
                          // Terms agreement checkbox
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _agreeToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _agreeToTerms = value ?? false;
                                  });
                                },
                                activeColor: AppColors.primary,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 12.sp,
                                    ),
                                    children: [
                                      TextSpan(text: 'Мен '),
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap: _showTermsModal,
                                          child: Text(
                                            'Пайдалану шарттары',
                                            style: AppTypography.bodySmall.copyWith(
                                              color: AppColors.primary,
                                              fontSize: 12.sp,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextSpan(text: ' және '),
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap: _showPrivacyModal,
                                          child: Text(
                                            'Құпиялылық саясатына',
                                            style: AppTypography.bodySmall.copyWith(
                                              color: AppColors.primary,
                                              fontSize: 12.sp,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextSpan(text: ' келісемін'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: 24.h),
                          
                          // Register button
                          PrimaryButton(
                            text: 'Тіркелу',
                            onPressed: _isLoading ? null : _completeRegistration,
                            height: 70,
                            width: double.infinity,
                            isLoading: _isLoading,
                          ),
                          
                          
                          SizedBox(height: 24.h),
                          
                          // Login prompt
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Аккаунтыңыз бар ма? ',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 14.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Кіру',
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.white.withOpacity(0.2),
            ),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.black.withOpacity(0.2),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTypography.bodyLarge.copyWith(
                color: AppColors.black.withOpacity(0.6),
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}