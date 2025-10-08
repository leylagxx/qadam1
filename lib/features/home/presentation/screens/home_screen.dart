import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/scaffold/gradient_scaffold.dart';
import '../providers/home_providers.dart';
import '../widgets/app_header.dart';
import '../widgets/daily_intent_card.dart';
import '../widgets/lesson_progress_card.dart';
import '../widgets/goal_card.dart';
import '../widgets/video_card.dart';
import '../widgets/course_card.dart';
import '../widgets/bottom_navigation.dart';
import 'video_player_screen.dart';

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
        height: 185.19.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ✅ Фото без чёрных полос, по центру
            if (thumbnailUrl != null)
              Image.network(
                thumbnailUrl!,
                fit: BoxFit.cover, // ключевое изменение
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: const Color(0xFF7B4AD6)),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                },
              ),

            // затемнение для текста
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),

            // текстовая часть
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 26.sp,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    subtitle,
                    style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: GoogleFonts.exo2(
                      fontSize: 13.sp,
                      color: Colors.white.withOpacity(0.9),
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          VideoPlayerScreen(videoUrl: videoUrl!, title: title),
                    ));
                  } else {
                    onPlay?.call();
                  }
                },
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.9),
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(Icons.play_arrow,
                      size: 40.w, color: AppColors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// Home screen - main dashboard
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final goals = ref.watch(activeGoalsProvider);
    final lessons = ref.watch(lessonsProvider);
    final notificationsCount = ref.watch(notificationsCountProvider);

    // Debug prints
    print('🏠 HomeScreen: userProfile loading: ${userProfile.isLoading}');
    print('🏠 HomeScreen: userProfile hasValue: ${userProfile.hasValue}');
    print('🏠 HomeScreen: userProfile value: ${userProfile.value}');
    if (userProfile.hasValue && userProfile.value != null) {
      print('🏠 HomeScreen: displayName: ${userProfile.value!.displayName}');
      print('🏠 HomeScreen: phoneNumber: ${userProfile.value!.phoneNumber}');
    }

    return GradientScaffold(
      body: Column(
        children: [
          // App Header
          AppHeader(
            userName: userProfile.value?.displayName,
            phoneNumber: userProfile.value?.phoneNumber,
            avatarUrl: userProfile.value?.avatarUrl,
            notificationCount: notificationsCount,
            onNotificationTap: () {
              // TODO: Navigate to notifications
            },
            onAvatarTap: () {
              // TODO: Navigate to profile
            },
          ),
          
          // Main content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(1.59, 0.44),
                  end: Alignment(-1.25, 0.65),
                  colors: [Color(0xFFC5A6FF), Color(0xFF5900FF)],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [
                    // Daily Intent Card
                    DailyIntentCard(
                      onTap: () {
                        _showDailyIntentDialog();
                      },
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Lesson Progress Card
                    if (lessons.value != null && lessons.value!.isNotEmpty)
                      LessonProgressCard(
                        lesson: lessons.value!.first,
                        onTap: () {
                          // TODO: Navigate to lessons
                        },
                      ),
                    
                    SizedBox(height: 16.h),
                    
                    // Goals Section with decorative waves
                    _buildGoalsSection(goals),
                    
                    SizedBox(height: 16.h),
                    
                    // Course Card
                    CourseCard(
                      onPurchase: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Переход к покупке курса "ПРОРЫВ ДЕНЬГИ"...'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Video Card
                    Center(
                      child: VideoCard(
                        title: 'РИФ ЕРЛАН',
                        subtitle: 'Play now',
                        description:
                            'МАҚСАТҚА ЖЕТУ ТІЛЕГЕНІҢ ОРЫНДАЛУ ҮШІН',
                        thumbnailUrl:
                            'https://firebasestorage.googleapis.com/v0/b/qadam-1.firebasestorage.app/o/photo_2025-10-07_14-23-52.jpg?alt=media&token=17b1c154-8637-454a-b212-09a5f902c5e9',
                        videoUrl:
                            'https://firebasestorage.googleapis.com/v0/b/qadam-1.firebasestorage.app/o/video.mp4?alt=media&token=62919378-0e12-42ef-805f-7c0b905647c0',
                      ),
                    ),

   
                    SizedBox(height: 50.h), // Space for bottom navigation
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // TODO: Navigate to different tabs
        },
      ),
    );
  }

  Widget _buildGoalsSection(List<dynamic> goals) {
    return Column(
      children: [
        // Goals title with decorative waves
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/left_wave.svg',
              width: 77.w,
              height: 11.h,
            ),
            Expanded(
              child: Text(
                'Менің мақсаттарым',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  fontSize: 16.sp,
                  color: const Color(0xFFFFFCFC),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/images/right_wave.svg',
              width: 77.w,
              height: 11.h,
            ),
          ],
        ),
        
        SizedBox(height: 16.h),
        
        // Goals container
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCFC),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0x1E9C9C9C),
                blurRadius: 32.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: goals.isEmpty
              ? _buildEmptyGoalsState()
              : Column(
                  children: goals.take(1).map((goal) => GoalCard(
                    goal: goal,
                    onAddContribution: () {
                      _showAddContributionDialog(goal);
                    },
                    onNewGoal: () {
                      _showNewGoalDialog();
                    },
                  )).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyGoalsState() {
    return Container(
      padding: EdgeInsets.all(32.w),
      child: Column(
        children: [
          Icon(
            Icons.flag_outlined,
            size: 48.w,
            color: const Color(0xFF999999),
          ),
          SizedBox(height: 16.h),
          Text(
            'Сізде әлі мақсаттар жоқ',
            style: GoogleFonts.exo2(
              fontSize: 16.sp,
              color: const Color(0xFF999999),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Жаңа мақсат қосып, өз жетістіктеріңізді бастаңыз',
            textAlign: TextAlign.center,
            style: GoogleFonts.exo2(
              fontSize: 14.sp,
              color: const Color(0xFF999999),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => _showNewGoalDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Жаңа мақсат қосу',
              style: GoogleFonts.exo2(
                fontSize: 14.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDailyIntentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Күн ниеті',
          style: GoogleFonts.pacifico(
            fontSize: 20.sp,
            color: AppColors.black,
          ),
        ),
        content: Text(
          'Бүгінгі күнге арналған ниетіңізді жазыңыз',
          style: GoogleFonts.dmSans(
            fontSize: 14.sp,
            color: const Color(0xFF666666),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Жабу',
              style: GoogleFonts.exo2(
                fontSize: 14.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddContributionDialog(dynamic goal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Жарна қосу',
          style: GoogleFonts.dmSans(
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          '${goal.title} мақсатына қанша қосқыңыз келеді?',
          style: GoogleFonts.dmSans(
            fontSize: 14.sp,
            color: const Color(0xFF666666),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Жабу',
              style: GoogleFonts.exo2(
                fontSize: 14.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNewGoalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Жаңа мақсат',
          style: GoogleFonts.exo2(
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Жаңа мақсат қосып, өз жетістіктеріңізді бастаңыз',
          style: GoogleFonts.exo2(
            fontSize: 14.sp,
            color: const Color(0xFF666666),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Жабу',
              style: GoogleFonts.exo2(
                fontSize: 14.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
