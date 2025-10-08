/// User entity representing a user in the system
class UserEntity {
  /// Unique identifier for the user
  final String id;
  
  /// User's full name
  final String fullName;
  
  /// User's email address
  final String email;
  
  /// User's phone number
  final String phoneNumber;
  
  /// Whether the user's email is verified
  final bool isEmailVerified;
  
  /// Whether the user's phone is verified
  final bool isPhoneVerified;
  
  /// User's profile creation timestamp
  final DateTime createdAt;
  
  /// User's last update timestamp
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy of this user with updated fields
  UserEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.id == id &&
        other.fullName == fullName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.isEmailVerified == isEmailVerified &&
        other.isPhoneVerified == isPhoneVerified &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        isEmailVerified.hashCode ^
        isPhoneVerified.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
