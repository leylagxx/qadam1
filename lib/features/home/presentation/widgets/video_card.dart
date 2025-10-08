import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/theme/app_colors.dart';
import '../screens/video_player_screen.dart';

class VideoCard extends StatelessWidget {
  final String? thumbnailUrl;
  final String title;
  final String subtitle;
  final String description;
  final String? videoUrl;
  final VoidCallback? onPlay;

  const VideoCard({
    super.key,
    this.thumbnailUrl,
    required this.title,
    required this.subtitle,
    required this.description,
    this.videoUrl,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: SizedBox(
        width: 346.87.w,
        height: 238.19.h,
        child: Stack(
          children: [
            // ✅ Фото полностью на фоне, без чёрных полос
            Positioned.fill(
              child: thumbnailUrl != null
                  ? FittedBox(
                      fit: BoxFit.fill, // принудительно растягивает по контейнеру
                      clipBehavior: Clip.none,
                      child: thumbnailUrl!.startsWith('http')
                          ? Image.network(
                              thumbnailUrl!,
                              width: 346.87.w,
                              height: 238.19.h,
                              errorBuilder: (context, error, stack) => Container(
                                color: const Color(0xFF7B4AD6),
                              ),
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(color: Colors.white),
                                );
                              },
                            )
                          : Image.asset(
                              thumbnailUrl!,
                              width: 346.87.w,
                              height: 238.19.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) => Container(
                                color: const Color(0xFF7B4AD6),
                              ),
                            ),
                    )
                  : Container(color: const Color(0xFF7B4AD6)),
            ),

            // затемнение
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),

            // текст
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 26.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    subtitle,
                    style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Opacity(
                    opacity: 0.9,
                    child: Text(
                      description,
                      style: GoogleFonts.exo2(
                        fontSize: 13.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // кнопка Play
            Center(
              child: GestureDetector(
                onTap: () {
                  if (videoUrl != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => VideoPlayerScreen(
                          videoUrl: videoUrl!,
                          title: title,
                        ),
                      ),
                    );
                  } else {
                    onPlay?.call();
                  }
                },
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFEDE8F7),
                    border: Border.all(color: Colors.white, width: 4.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 40.w,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}