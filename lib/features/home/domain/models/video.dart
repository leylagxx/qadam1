class Video {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String videoUrl;
  final String? thumbnailUrl;
  final Duration duration;
  final bool isCompleted;
  final DateTime createdAt;

  const Video({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.videoUrl,
    this.thumbnailUrl,
    required this.duration,
    this.isCompleted = false,
    required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      duration: Duration(seconds: json['duration'] as int),
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration.inSeconds,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Video copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? videoUrl,
    String? thumbnailUrl,
    Duration? duration,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
