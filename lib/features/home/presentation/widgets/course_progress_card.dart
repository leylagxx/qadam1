import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Course progress card for users who already purchased the course
class CourseProgressCard extends StatelessWidget {
  final VoidCallback? onContinue;

  const CourseProgressCard({
    super.key,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 433.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFECEFF3),
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Stack(
        children: [
          // Course image
          Positioned(
            left: 16.w,
            top: 16.h,
            child: Container(
              width: 295.w,
              height: 200.h,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: NetworkImage("https://placehold.co/295x200"),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Stack(
                children: [
                  // Play button overlay
                  Positioned(
                    left: 247.w,
                    top: 16.h,
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white.withValues(alpha: 0.20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 4.w,
                            top: 4.h,
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Course info section
          Positioned(
            left: 16.w,
            top: 231.h,
            child: Container(
              width: 295.w,
              padding: const EdgeInsets.only(bottom: 16),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: const Color(0xFFECEFF3),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 295.w,
                    height: 33.h,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'ПРОРЫВ ДЕНЬГИ            . ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.55,
                            ),
                          ),
                          TextSpan(
                            text: 'Куплено',
                            style: TextStyle(
                              color: const Color(0xFF00C851),
                              fontSize: 18.sp,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 167.w,
                    child: Text(
                      '10 Сабақ | 4h 32m | 980 Қатысушы',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 280.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 22.w,
                          height: 22.h,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 22.w,
                                  height: 22.h,
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: NetworkImage("https://placehold.co/22x22"),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(37.r),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SizedBox(
                          width: 140.w,
                          height: 15.h,
                          child: Text(
                            'Риф Ерлан | Наставник',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Date
          Positioned(
            left: 16.w,
            top: 303.h,
            child: SizedBox(
              width: 295.w,
              height: 22.h,
              child: Text(
                '11.09.2024',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFF818898),
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.55,
                  letterSpacing: -0.28,
                ),
              ),
            ),
          ),
          
          // Progress section
          Positioned(
            left: 16.w,
            top: 350.h,
            child: Container(
              width: 295.w,
              height: 38.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Progress bar
                  Container(
                    width: 200.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.3, // 30% progress
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  
                  // Progress percentage
                  Text(
                    '30%',
                    style: TextStyle(
                      color: const Color(0xFF10B981),
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Continue button
          Positioned(
            left: 27.w,
            top: 393.h,
            child: GestureDetector(
              onTap: onContinue,
              child: Container(
                width: 273.w,
                padding: const EdgeInsets.only(top: 6, left: 12, bottom: 6),
                decoration: ShapeDecoration(
                  color: const Color(0xFF10B981),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 166.w,
                      child: Text(
                        'ПРОДОЛЖИТЬ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'Fascinate',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: 16.w,
                      height: 16.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF0FDF4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.h,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFF10B981),
                                  shape: OvalBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

