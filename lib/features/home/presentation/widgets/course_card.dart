import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String priceText;
  final String coverImage; // путь к asset или url
  final String mentorName;
  final String dateText;
  final String metaText;
  final VoidCallback? onPurchase;

  const CourseCard({
    super.key,
    this.title = 'ПРОРЫВ ДЕНЬГИ',
    this.priceText = '19,990 ₸',
    this.coverImage = 'assets/images/rif_erlan_video.jpg',
    this.mentorName = 'Риф Ерлан | Наставник',
    this.dateText = '11.09.2024',
    this.metaText = '10 Сабақ | 4h 32m | 980 Қатысушы',
    this.onPurchase,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 327.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFECEFF3), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14000000),
              blurRadius: 12.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---------- COVER ----------
            SizedBox(
              width: double.infinity,
              height: 200.h,
              child: _buildCover(coverImage),
            ),
            SizedBox(height: 16.h),

            // ---------- TITLE + PRICE ----------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Row(
                  children: [
                    Text(
                      '· ',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      priceText,
                      style: GoogleFonts.dmSans(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF0000),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6.h),

            // ---------- META ----------
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                metaText,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF818898),
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // ---------- MENTOR + DATE ----------
            Row(
              children: [
                Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(37.r),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/User Profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    mentorName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mulish(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  dateText,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.28,
                    color: const Color(0xFF818898),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            const Divider(height: 1, color: Color(0xFFECEFF3)),
            SizedBox(height: 12.h),

            // ---------- AVATARS + PROGRESS ----------
            Row(
              children: [
                _OverlappedAvatars(
                  colors: [
                    const Color(0xFFFFC7D6),
                    const Color(0xFFDBD1FC),
                    const Color(0xFFFFD9A2),
                    const Color(0xFFBEF0C6),
                  ],
                ),
                const Spacer(),
                _ProgressBadge(percent: 0),
              ],
            ),

            SizedBox(height: 16.h),

            // ---------- BUY BUTTON ----------
            _BuyButton(onTap: onPurchase),
          ],
        ),
      ),
    );
  }

  ImageProvider _imageProvider(String pathOrUrl) {
    if (pathOrUrl.startsWith('http')) {
      return NetworkImage(pathOrUrl);
    }
    return AssetImage(pathOrUrl);
  }

  // ---------- COVER WITH LOGO + PLAY ----------
  Widget _buildCover(String pathOrUrl) {
    final provider = _imageProvider(pathOrUrl);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: provider,
              fit: BoxFit.cover, // ✅ Заполняет без чёрных полос
              alignment: Alignment.center,
            ),
          ),

          // Логотип "ПРОРЫВ"
          Positioned(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/proryv_logo.png',
                    fit: BoxFit.contain,
                  ),
                  
                ],
              ),
            ),
          ),

          // Кнопка воспроизведения
          Positioned(
            top: 16.h,
            right: 16.w,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- AVATARS ----------
class _OverlappedAvatars extends StatelessWidget {
  final List<Color> colors;
  const _OverlappedAvatars({required this.colors});

  @override
  Widget build(BuildContext context) {
    final items = colors.take(4).toList();
    return SizedBox(
      height: 32.w,
      width: (items.length * 22 + 10).w,
      child: Stack(
        children: [
          for (int i = 0; i < items.length; i++)
            Positioned(
              left: (i * 22).w,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(124.88.r),
                  border: Border.all(color: Colors.white, width: 2),
                  color: items[i],
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 16.w,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------- PROGRESS ----------
class _ProgressBadge extends StatelessWidget {
  final int percent;
  const _ProgressBadge({required this.percent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 32.w,
          height: 32.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1EEFD),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 22.w,
                height: 22.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF6F51EC),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$percent%',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.24,
                color: const Color(0xFF0D0D12),
              ),
            ),
            Text(
              'Progress',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.24,
                color: const Color(0xFF818898),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------- BUY BUTTON ----------
class _BuyButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _BuyButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          color: const Color(0xFFFE0004),
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0x33FE0004),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            // Левая точка
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF2FFFB),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF0000),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'САТЫП АЛУ',
                  style: GoogleFonts.fascinate(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFE0004),
                    shape: BoxShape.circle,
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
