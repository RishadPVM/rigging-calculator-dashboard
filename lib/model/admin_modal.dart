class AdminModel {
  final String id;
  final String email;
  final String adminName;
  final String? profilePhoto;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final bool isBlocked;
  final String type;
  final Roles roles;

  AdminModel({
    required this.id,
    required this.email,
    required this.adminName,
    this.profilePhoto,
    required this.createdAt,
    this.lastActiveAt,
    required this.isBlocked,
    required this.type,
    required this.roles,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      email: json['email'],
      adminName: json['adminName'],
      profilePhoto: json['profilePhoto'],
      createdAt: DateTime.parse(json['createdAt']),
      lastActiveAt: json['lastActiveAt'] != null
          ? DateTime.parse(json['lastActiveAt'])
          : null,
      isBlocked: json['isBlocked'],
      type: json['type'],
      roles: Roles.fromJson(json['roles']),
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
      'roles': roles.toJson(),
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
  final bool brandCreate;
  final bool brandEdit;
  final bool categoryView;
  final bool categoryCreate;
  final bool categoryEdit;
  final bool adsView;
  final bool adsBlockOption;
  final bool adsVerifiyOption;
  final bool adsPlanView;
  final bool adsPlanCreate;
  final bool adsPlanEdit;

  Roles({
    required this.adminId,
    required this.userView,
    required this.sponsorView,
    required this.craneSellerView,
    required this.craneView,
    required this.brandView,
    required this.brandCreate,
    required this.brandEdit,
    required this.categoryView,
    required this.categoryCreate,
    required this.categoryEdit,
    required this.adsView,
    required this.adsBlockOption,
    required this.adsVerifiyOption,
    required this.adsPlanView,
    required this.adsPlanCreate,
    required this.adsPlanEdit,
  });

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(
      adminId: json['adminId'],
      userView: json['userView']??false,
      sponsorView: json['sponsorView']??false,
      craneSellerView: json['craneSellerView']??false,
      craneView: json['craneView']??false,
      brandView: json['brandView']??false,
      brandCreate: json['brandCreate']??false,
      brandEdit: json['brandEdit']??false,
      categoryView: json['categoryView']??false,
      categoryCreate: json['categoryCreate']??false,
      categoryEdit: json['categoryEdit']??false,
      adsView: json['adsView']??false,
      adsBlockOption: json['adsBlockOption']??false,
      adsVerifiyOption: json['adsVerifiyOption']??false,
      adsPlanView: json['adsPlanView']??false,
      adsPlanCreate: json['adsPlanCreate']??false,
      adsPlanEdit: json['adsPlanEdit']??false,
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
      'brandCreate': brandCreate,
      'brandEdit': brandEdit,
      'categoryView': categoryView,
      'categoryCreate': categoryCreate,
      'categoryEdit': categoryEdit,
      'adsView': adsView,
      'adsBlockOption': adsBlockOption,
      'adsVerifiyOption': adsVerifiyOption,
      'adsPlanView': adsPlanView,
      'adsPlanCreate': adsPlanCreate,
      'adsPlanEdit': adsPlanEdit,
    };
  }
}
