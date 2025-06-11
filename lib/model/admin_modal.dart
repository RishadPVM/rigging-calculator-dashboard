class AdminModel {
  final String id;
  final String email;
  final String adminName;
  final String? profilePhoto;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final bool isBlocked;
  final String type;
  final Roles? roles;

  AdminModel({
    required this.id,
    required this.email,
    required this.adminName,
    this.profilePhoto,
    required this.createdAt,
    this.lastActiveAt,
    required this.isBlocked,
    required this.type,
    this.roles,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      email: json['email'],
      adminName: json['adminName'],
      profilePhoto: json['profilePhoto'],
      createdAt: DateTime.parse(json['createdAt']),
      lastActiveAt:
          json['lastActiveAt'] != null ? DateTime.parse(json['lastActiveAt']) : null,
      isBlocked: json['isBlocked'],
      type: json['type'],
      roles: json['roles'] != null ? Roles.fromJson(json['roles']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'adminName': adminName,
      'profilePhoto': profilePhoto,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt?.toIso8601String(),
      'isBlocked': isBlocked,
      'type': type,
      'roles': roles?.toJson(),
    };
  }
}

class Roles {
  final String adminId;
  final bool userView;
  final bool sponsorView;
  final bool craneSellerView;
  final bool craneView;
  final bool brandView;
  final bool brandEdit;
  final bool categoryView;
  final bool categoryEdit;
  final bool adsView;

  Roles({
    required this.adminId,
    required this.userView,
    required this.sponsorView,
    required this.craneSellerView,
    required this.craneView,
    required this.brandView,
    required this.brandEdit,
    required this.categoryView,
    required this.categoryEdit,
    required this.adsView,
  });

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(
      adminId: json['adminId'],
      userView: json['userView']??false,
      sponsorView: json['sponsorView']??false,
      craneSellerView: json['craneSellerView']??false,
      craneView: json['craneView']??false,
      brandView: json['brandView']??false,
      brandEdit: json['brandEdit']??false,
      categoryView: json['categoryView']??false,
      categoryEdit: json['categoryEdit']??false,
      adsView: json['adsView']??false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminId': adminId,
      'userView': userView,
      'sponsorView': sponsorView,
      'craneSellerView': craneSellerView,
      'craneView': craneView,
      'brandView': brandView,
      'brandEdit': brandEdit,
      'categoryView': categoryView,
      'categoryEdit': categoryEdit,
      'adsView': adsView,
    };
  }
}
