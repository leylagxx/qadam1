import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/theme/app_colors.dart';

/// App header with user info and notifications
class AppHeader extends StatelessWidget {
  final String? userName;
  final String? phoneNumber;
  final String? avatarUrl;
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;

  const AppHeader({
    super.key,
    this.userName,
    this.phoneNumber,
    this.avatarUrl,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          GestureDetector(
            onTap: onAvatarTap,
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: avatarUrl != null
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(avatarUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: avatarUrl == null
                  ? SvgPicture.asset(
                      'assets/images/default_ava.svg',
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          SizedBox(width: 16.w),
          
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName != null && userName!.isNotEmpty 
                    ? 'Сәлем, $userName' 
                    : 'Сәлем!',
                  style: GoogleFonts.pacifico(
                    fontSize: 22.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    height: 1.27,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  phoneNumber ?? '+7 777 777 77 77',
                  style: GoogleFonts.exo2(
                    fontSize: 14.sp,
                    color: const Color(0xFF999999),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          
          // Notifications
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(
              width: 46.w,
              height: 46.w,
              decoration: BoxDecoration(
                color: const Color(0xFF7B4AD6),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.white,
                      size: 20.w,
                    ),
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      right: 8.w,
                      top: 8.h,
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDF1C41),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF7B4AD6),
                            width: 2.w,
                          ),
                        ),
                        child: Center(
                          child:                             Text(
                              notificationCount > 9 ? '9+' : notificationCount.toString(),
                              style: GoogleFonts.exo2(
                                fontSize: 8.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ),
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
