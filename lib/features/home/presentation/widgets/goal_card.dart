import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../domain/models/goal.dart';

/// Goal card widget
class GoalCard extends StatelessWidget {
  final Goal goal;
  final VoidCallback? onAddContribution;
  final VoidCallback? onNewGoal;

  const GoalCard({
    super.key,
    required this.goal,
    this.onAddContribution,
    this.onNewGoal,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercentage = goal.progressPercentage;
    final daysRemaining = goal.daysRemaining;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
          // Goal header
          Row(
            children: [
              // Goal image
              Container(
                width: 43.w,
                height: 43.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: goal.imageUrl != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(goal.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/images/mac_mini.png'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 16.w),
              
              // Goal details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      style: GoogleFonts.dmSans(
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
                            text: goal.formattedCurrentAmount,
                            style: GoogleFonts.dmSans(
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' / ',
                            style: GoogleFonts.dmSans(
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: goal.formattedTargetAmount,
                            style: GoogleFonts.dmSans(
                              fontSize: 16.sp,
                              color: const Color(0xFF49CAE6),
                              fontWeight: FontWeight.w700,
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
          SizedBox(height: 12.h),
          
          // Time indicator
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.00, 0.50),
                end: Alignment(1.00, 0.50),
                colors: [Color(0xFFEFEFEF), Colors.white],
              ),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18.w,
                  color: AppColors.black,
                ),
                SizedBox(width: 10.w),
                Text(
                  '${daysRemaining} күнде',
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          
          // Progress bar
          Row(
            children: [
              Text(
                '${(progressPercentage * 100).toInt()}%',
                style: GoogleFonts.dmSans(
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF8FF),
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: const Color(0xFFCBF0F8),
                      width: 1.w,
                    ),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF49CAE6),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onAddContribution,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Жарна қосу',
                          style: GoogleFonts.dmSans(
                            fontSize: 12.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
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
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: GestureDetector(
                  onTap: onNewGoal,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Жаңа мақсат',
                          style: GoogleFonts.dmSans(
                            fontSize: 12.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.add,
                          size: 16.w,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
