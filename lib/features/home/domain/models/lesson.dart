import 'package:cloud_firestore/cloud_firestore.dart';

/// Lesson model for course progress
class Lesson {
  final String id;
  final String title;
  final String description;
  final String courseId;
  final int order;
  final int totalLessons;
  final int completedLessons;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? thumbnailUrl;
  final String? videoUrl;
  final int durationMinutes;
  final bool isCompleted;
  final LessonStatus status;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.order,
    required this.totalLessons,
    required this.completedLessons,
    required this.createdAt,
    required this.updatedAt,
    this.thumbnailUrl,
    this.videoUrl,
    this.durationMinutes = 0,
    this.isCompleted = false,
    this.status = LessonStatus.notStarted,
  });

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      courseId: map['courseId'] ?? '',
      order: map['order'] ?? 0,
      totalLessons: map['totalLessons'] ?? 0,
      completedLessons: map['completedLessons'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      thumbnailUrl: map['thumbnailUrl'],
      videoUrl: map['videoUrl'],
      durationMinutes: map['durationMinutes'] ?? 0,
      isCompleted: map['isCompleted'] ?? false,
      status: LessonStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => LessonStatus.notStarted,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'courseId': courseId,
      'order': order,
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'durationMinutes': durationMinutes,
      'isCompleted': isCompleted,
      'status': status.name,
    };
  }

  double get progressPercentage {
    if (totalLessons == 0) return 0.0;
    return (completedLessons / totalLessons).clamp(0.0, 1.0);
  }

  String get progressText => '$completedLessons / $totalLessons';

  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    if (hours > 0) {
      return '${hours}ч ${minutes}м';
    }
    return '${minutes}м';
  }

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    String? courseId,
    int? order,
    int? totalLessons,
    int? completedLessons,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? thumbnailUrl,
    String? videoUrl,
    int? durationMinutes,
    bool? isCompleted,
    LessonStatus? status,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      courseId: courseId ?? this.courseId,
      order: order ?? this.order,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      status: status ?? this.status,
    );
  }
}

enum LessonStatus {
  notStarted,
  inProgress,
  completed,
  locked,
}
