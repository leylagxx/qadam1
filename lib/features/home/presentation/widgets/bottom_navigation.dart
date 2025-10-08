import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/theme/app_colors.dart';

/// Elegant bottom navigation bar styled for QADAM app
class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

 @override
Widget build(BuildContext context) {
  return Container(
    height: 88.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.85),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28.r),
        topRight: Radius.circular(28.r),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, -4),
        ),
      ],
    ),
    clipBehavior: Clip.none, // ✅ позволяет кнопке выходить за границы
    child: Stack(
      clipBehavior: Clip.none, // ✅ не обрезаем плавающую кнопку
      alignment: Alignment.center,
      children: [
        // ряд навигации
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              index: 0,
              icon: Icons.home_rounded,
              label: 'Басты',
              isActive: currentIndex == 0,
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.menu_book_rounded,
              label: 'Сабақтар',
              isActive: currentIndex == 1,
            ),
            SizedBox(width: 64.w),
            _buildNavItem(
              index: 2,
              icon: Icons.handyman_rounded,
              label: 'Құралдар',
              isActive: currentIndex == 2,
            ),
            _buildNavItem(
              index: 3,
              icon: Icons.chat_bubble_rounded,
              label: 'Чат',
              isActive: currentIndex == 3,
            ),
          ],
        ),

        // ✅ центральная кнопка теперь полностью видима
        Positioned(
          bottom: 24.h, // чуть выше, чтобы не обрезалась
          child: GestureDetector(
            onTap: () => onTap(4),
            child: Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                size: 30.w,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFFEDE8F7)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              icon,
              size: 22.w,
              color:
                  isActive ? const Color(0xFF8645FF) : const Color(0xFF70747D),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
              color: isActive
                  ? const Color(0xFF8645FF)
                  : const Color(0xFF70747D),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}