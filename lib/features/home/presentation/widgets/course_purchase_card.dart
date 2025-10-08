import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Course purchase card for new users
class CoursePurchaseCard extends StatelessWidget {
  final VoidCallback? onPurchase;

  const CoursePurchaseCard({
    super.key,
    this.onPurchase,
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
                  image: AssetImage("assets/images/proryv_logo.png"),
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                            text: '19,990 ₸',
                            style: TextStyle(
                              color: const Color(0xFFFF0000),
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
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 167.w,
                    child: Text(
                      '10 Сабақ | 4h 32m | 980 Қатысушы',
                      style: TextStyle(
                        color: const Color(0xFF6B7280),
                        fontSize: 10.sp,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
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
            top: 315.h,
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
          
          // Participants and progress
          Positioned(
            left: 16.w,
            top: 350.h,
            child: Container(
              width: 295.w,
              height: 38.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Participant avatars
                      _buildParticipantAvatar(
                        color: const Color(0xFFFFC7D6),
                        imageUrl: "https://placehold.co/32x22",
                      ),
                      SizedBox(width: 8.w),
                      _buildParticipantAvatar(
                        color: const Color(0xFFDBD1FC),
                        imageUrl: "https://placehold.co/32x32",
                      ),
                      SizedBox(width: 8.w),
                      _buildParticipantAvatar(
                        color: const Color(0xFFFFD9A2),
                        imageUrl: "https://placehold.co/32x32",
                      ),
                      SizedBox(width: 8.w),
                      _buildParticipantAvatar(
                        color: const Color(0xFFBEF0C6),
                        imageUrl: "https://placehold.co/32x32",
                      ),
                    ],
                  ),
                  
                  // Progress section
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFF1EEFD),
                          shape: OvalBorder(),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF6F51EC),
                          shape: OvalBorder(),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '0%',
                            style: TextStyle(
                              color: const Color(0xFF0D0D12),
                              fontSize: 12.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.55,
                              letterSpacing: -0.24,
                            ),
                          ),
                          Text(
                            'Progress',
                            style: TextStyle(
                              color: const Color(0xFF818898),
                              fontSize: 12.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.55,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Purchase button
          Positioned(
            left: 16.w,
            top: 400.h,
            child: GestureDetector(
              onTap: onPurchase,
              child: Container(
                width: 295.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFE0004),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'САТЫП АЛУ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontFamily: 'Fascinate',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 8.w),
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
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2FFFB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFFF0000),
                          shape: OvalBorder(),
                        ),
                      ),
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

  Widget _buildParticipantAvatar({
    required Color color,
    required String imageUrl,
  }) {
    return Container(
      width: 32.w,
      height: 32.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(124.88.r),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
