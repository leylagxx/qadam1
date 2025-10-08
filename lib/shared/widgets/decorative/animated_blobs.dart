import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';

/// Animated background blobs widget
class AnimatedBlobs extends StatefulWidget {
  const AnimatedBlobs({super.key});

  @override
  State<AnimatedBlobs> createState() => _AnimatedBlobsState();
}

class _AnimatedBlobsState extends State<AnimatedBlobs>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();
    
    _controller1 = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    
    _controller2 = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();
    
    _controller3 = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blob 1
        AnimatedBuilder(
          animation: _controller1,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                50.w + 30.w * _controller1.value,
                100.h + 20.h * _controller1.value,
              ),
              child: Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
            );
          },
        ),
        
        // Blob 2
        AnimatedBuilder(
          animation: _controller2,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                200.w + 40.w * _controller2.value,
                300.h + 30.h * _controller2.value,
              ),
              child: Container(
                width: 150.w,
                height: 150.w,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(75.w),
                ),
              ),
            );
          },
        ),
        
        // Blob 3
        AnimatedBuilder(
          animation: _controller3,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                100.w + 25.w * _controller3.value,
                200.h + 15.h * _controller3.value,
              ),
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(60.w),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

