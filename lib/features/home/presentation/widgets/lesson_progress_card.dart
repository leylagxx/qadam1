import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../domain/models/lesson.dart';

/// Lesson progress card widget
class LessonProgressCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback? onTap;

  const LessonProgressCard({
    super.key,
    required this.lesson,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercentage = lesson.progressPercentage;
    final progressText = lesson.progressText;

    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        top: 12.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0C000000),
            blurRadius: 24.r,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 6.h, left: 12.w, bottom: 6.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.00, 0.50),
                end: Alignment(1.00, 0.50),
                colors: [Color(0xFF8E57F5), Colors.white],
              ),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    lesson.title,
                    style: GoogleFonts.exo2(
                      fontSize: 15.sp,
                      color: const Color(0xFF0D0916),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2FFFB),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF49CAE6),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Өту',
                      style: GoogleFonts.exo2(
                        fontSize: 14.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.w,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          
          // Progress section
          Row(
            children: [
              // Circular progress
              Container(
                width: 102.w,
                height: 52.h,
                child: Stack(
                  children: [
                    // Background circle
                    Positioned(
                      left: 0.02.w,
                      top: 1.18.h,
                      child: Container(
                        width: 102.w,
                        height: 102.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF49CAE6),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Progress indicator
                    Positioned(
                      left: 34.99.w,
                      top: 0.66.h,
                      child: Transform.rotate(
                        angle: -0.30,
                        child: Container(
                          width: 2.22.w,
                          height: 21.57.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF19A4CB),
                            borderRadius: BorderRadius.circular(1.75.r),
                          ),
                        ),
                      ),
                    ),
                    // Progress text
                    Center(
                      child: Text(
                        '${(progressPercentage * 100).toInt()}%',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.exo2(
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              
              // Progress details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Қаралған сабақтар:',
                      style: GoogleFonts.exo2(
                        fontSize: 14.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${lesson.completedLessons} / ',
                            style: GoogleFonts.exo2(
                              fontSize: 22.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                              height: 1.27,
                            ),
                          ),
                          TextSpan(
                            text: '${lesson.totalLessons}',
                            style: GoogleFonts.exo2(
                              fontSize: 22.sp,
                              color: const Color(0xFF49CAE6),
                              fontWeight: FontWeight.w800,
                              height: 1.27,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
