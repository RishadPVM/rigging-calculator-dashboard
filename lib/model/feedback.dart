class FeedbackModel {
  final String id;
  final String userId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      userId: json['userId'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'message': message,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'user': user.toJson(),
      };
}

class User {
  final String id;
  final String email;
  final DateTime createdAt;
  final bool isVerified;
  final bool isPaymentStatus;
  final String? otp;
  final String? otpExpiry;
  final String? subscriptionExpiry;
  final String? companyLogo;
  final String? companyName;
  final String country;
  final String? lastActiveAt;
  final bool isAndroidUser;

  User({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.isVerified,
    required this.isPaymentStatus,
    this.otp,
    this.otpExpiry,
    this.subscriptionExpiry,
    this.companyLogo,
    this.companyName,
    required this.country,
    this.lastActiveAt,
    required this.isAndroidUser,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      isVerified: json['isVerified'],
      isPaymentStatus: json['isPaymentStatus'],
      otp: json['otp'],
      otpExpiry: json['otpExpiry'],
      subscriptionExpiry: json['subscriptionExpiry'],
      companyLogo: json['companyLogo'],
      companyName: json['companyName'],
      country: json['country'],
      lastActiveAt: json['lastActiveAt'],
      isAndroidUser: json['isAndroidUser'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'createdAt': createdAt.toIso8601String(),
        'isVerified': isVerified,
        'isPaymentStatus': isPaymentStatus,
        'otp': otp,
        'otpExpiry': otpExpiry,
        'subscriptionExpiry': subscriptionExpiry,
        'companyLogo': companyLogo,
        'companyName': companyName,
        'country': country,
        'lastActiveAt': lastActiveAt,
        'isAndroidUser': isAndroidUser,
      };
}
