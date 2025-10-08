import 'package:cloud_firestore/cloud_firestore.dart';

/// Goal model for user's objectives
class Goal {
  final String id;
  final String userId;
  final String title;
  final String description;
  final double currentAmount;
  final double targetAmount;
  final String currency;
  final DateTime targetDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? imageUrl;
  final bool isCompleted;
  final GoalCategory category;

  const Goal({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.currentAmount,
    required this.targetAmount,
    required this.currency,
    required this.targetDate,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
    this.isCompleted = false,
    this.category = GoalCategory.other,
  });

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      currentAmount: (map['currentAmount'] ?? 0.0).toDouble(),
      targetAmount: (map['targetAmount'] ?? 0.0).toDouble(),
      currency: map['currency'] ?? '₸',
      targetDate: (map['targetDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: map['imageUrl'],
      isCompleted: map['isCompleted'] ?? false,
      category: GoalCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => GoalCategory.other,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'currentAmount': currentAmount,
      'targetAmount': targetAmount,
      'currency': currency,
      'targetDate': Timestamp.fromDate(targetDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'imageUrl': imageUrl,
      'isCompleted': isCompleted,
      'category': category.name,
    };
  }

  double get progressPercentage {
    if (targetAmount == 0) return 0.0;
    return (currentAmount / targetAmount).clamp(0.0, 1.0);
  }

  int get daysRemaining {
    final now = DateTime.now();
    final difference = targetDate.difference(now).inDays;
    return difference > 0 ? difference : 0;
  }

  String get formattedCurrentAmount {
    return '${currentAmount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )} $currency';
  }

  String get formattedTargetAmount {
    return '${targetAmount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )} $currency';
  }

  Goal copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    double? currentAmount,
    double? targetAmount,
    String? currency,
    DateTime? targetDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
    bool? isCompleted,
    GoalCategory? category,
  }) {
    return Goal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      currentAmount: currentAmount ?? this.currentAmount,
      targetAmount: targetAmount ?? this.targetAmount,
      currency: currency ?? this.currency,
      targetDate: targetDate ?? this.targetDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
    );
  }
}

enum GoalCategory {
  technology,
  education,
  health,
  travel,
  business,
  other,
}
