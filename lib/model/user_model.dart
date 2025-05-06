import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final DateTime createdAt;
  final bool isVerified;
  final bool isPaymentStatus;
  final DateTime? subscriptionExpiry;
  final DateTime? lastActiveAt;
  final String? companyLogo;
  final String? companyName;
  final String? country;

  UserModel({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.isVerified,
    required this.isPaymentStatus,
    this.subscriptionExpiry,
    this.companyLogo,
    this.companyName,
    this.lastActiveAt,
    this.country,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      isVerified: json['isVerified'],
      isPaymentStatus: json['isPaymentStatus'],
      subscriptionExpiry:
          json['subscriptionExpiry'] != null
              ? DateTime.tryParse(json['subscriptionExpiry'])
              : null,
      lastActiveAt:
          json['lastActiveAt'] != null
              ? DateTime.tryParse(json['lastActiveAt'])
              : null,
      companyLogo: json['companyLogo'],
      companyName: json['companyName'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'isVerified': isVerified,
      'isPaymentStatus': isPaymentStatus,
      'subscriptionExpiry': subscriptionExpiry?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
