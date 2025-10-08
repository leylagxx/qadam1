import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import '../../../../shared/theme/app_colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String title;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlayerReady = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isPlayerReady = true;
        });
        print('🎬 VideoPlayer: Video initialized successfully');
      }
    }).catchError((error) {
      print('🎬 VideoPlayer: Error initializing video: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка загрузки видео: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Video Player
          Expanded(
            flex: 3,
            child: Container(
              color: AppColors.black,
              child: _isPlayerReady
                  ? Stack(
                      children: [
                        Center(
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        // Play/Pause Button
                        Center(
                          child: GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.w,
                                ),
                              ),
                              child: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 40.w,
                              ),
                            ),
                          ),
                        ),
                        // Progress Bar
                        Positioned(
                          bottom: 20.h,
                          left: 20.w,
                          right: 20.w,
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: AppColors.primary,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              bufferedColor: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Загрузка видео...',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          
          // Video Info
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(24.w),
              color: AppColors.black,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const Text(
                    'МАҚСАТҚА ЖЕТУ ТІЛЕГЕНІҢ ОРЫНДАЛУ ҮШІН',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const Text(
                    'Риф Ерланның мотивациялық видеосы. Мақсатқа жету үшін қажетті күш пен көзқарасты табыңыз.',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  
                  // Debug Info
                  Container(
                    padding: EdgeInsets.all(12.w),
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    
                  ),
                  
                  
                  // Video Controls
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      // Play/Pause Button
                      ElevatedButton.icon(
                        onPressed: _isPlayerReady ? _togglePlayPause : null,
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: AppColors.white,
                          size: 16.w,
                        ),
                        label: Text(
                          _isPlaying ? 'Пауза' : 'Воспроизведение',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                        ),
                      ),
                      
                      // Fullscreen Button
                      ElevatedButton.icon(
                        onPressed: _isPlayerReady
                            ? () {
                                // TODO: Implement fullscreen
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Полноэкранный режим в разработке'),
                                  ),
                                );
                              }
                            : null,
                        icon: Icon(
                          Icons.fullscreen,
                          color: AppColors.white,
                          size: 16.w,
                        ),
                        label: Text(
                          'Полный экран',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary.withOpacity(0.7),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
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