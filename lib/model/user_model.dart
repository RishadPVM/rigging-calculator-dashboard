import 'sponcer_model.dart';

class UserModel {
  final String id;
  final String email;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final bool isVerified;
  final bool isPaymentStatus;
  final DateTime? subscriptionExpiry;
  final String? companyLogo;
  final String? companyName;
  final String country;
  final bool? isAndroidUser;
  final List<dynamic> cranes;
  final List<SponsorAdModel> sponsorAds;

  UserModel({
    required this.id,
    required this.email,
    required this.createdAt,
    this.lastActiveAt,
    required this.isVerified,
    required this.isPaymentStatus,
    this.subscriptionExpiry,
    this.companyLogo,
    this.companyName,
    required this.country,
    this.isAndroidUser,
    required this.cranes,
    required this.sponsorAds,
  });

factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'],
    email: json['email'],
    createdAt: DateTime.parse(json['createdAt']),
    lastActiveAt: json['lastActiveAt'] != null
        ? DateTime.parse(json['lastActiveAt'])
        : null,
    isVerified: json['isVerified'],
    isPaymentStatus: json['isPaymentStatus'],
    subscriptionExpiry: json['subscriptionExpiry'] != null
        ? DateTime.parse(json['subscriptionExpiry'])
        : null,
    companyLogo: json['companyLogo'],
    companyName: json['companyName'],
    country: json['country'],
    isAndroidUser: json['isAndroidUser'],
    cranes: json['cranes'] != null ? List<dynamic>.from(json['cranes']) : [],
    sponsorAds: (json['SponsorAds'] as List<dynamic>? ?? [])
        .map((adJson) => SponsorAdModel.fromJson(adJson))
        .toList(),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt?.toIso8601String(),
      'isVerified': isVerified,
      'isPaymentStatus': isPaymentStatus,
      'subscriptionExpiry': subscriptionExpiry?.toIso8601String(),
      'companyLogo': companyLogo,
      'companyName': companyName,
      'country': country,
      'isAndroidUser': isAndroidUser,
      'cranes': cranes,
      'SponsorAds': sponsorAds,
    };
  }
}
