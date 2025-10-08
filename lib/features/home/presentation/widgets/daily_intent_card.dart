import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/theme/app_colors.dart';

/// Daily intent card widget
class DailyIntentCard extends StatelessWidget {
  final String? dailyIntent;
  final VoidCallback? onTap;

  const DailyIntentCard({
    super.key,
    this.dailyIntent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0C000000),
            blurRadius: 24.r,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 45.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: const Color(0xFF7B4AD6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              'assets/images/kun_nieti.png',
              width: 24.w,
              height: 24.h,
            ),
          ),
          SizedBox(width: 12.w),
          
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ниет – амалдың бастауы',
                  style: GoogleFonts.exo2(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Күн ниеті',
                  style: GoogleFonts.pacifico(
                    fontSize: 24.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    height: 1.17,
                  ),
                ),
              ],
            ),
          ),
          
          // Action button
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    size: 18.w,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Ашу',
                    style: GoogleFonts.exo2(
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
