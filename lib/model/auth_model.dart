class LoginResponse {
  final bool status;
  final Admin admin;
  final String token;

  LoginResponse({
    required this.status,
    required this.admin,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      admin: Admin.fromJson(json['admin']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'admin': admin.toJson(),
        'token': token,
      };
}

class Admin {
  final String id;
  final String email;
  final String adminName;
  final String? profilePhoto;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final String? otp;
  final DateTime? otpExpiry;

  Admin({
    required this.id,
    required this.email,
    required this.adminName,
    this.profilePhoto,
    required this.createdAt,
    this.lastActiveAt,
    this.otp,
    this.otpExpiry,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      email: json['email'],
      adminName: json['adminName'],
      profilePhoto: json['profilePhoto'],
      createdAt: DateTime.parse(json['createdAt']),
      lastActiveAt: json['lastActiveAt'] != null ? DateTime.tryParse(json['lastActiveAt']) : null,
      otp: json['otp'],
      otpExpiry: json['otpExpiry'] != null ? DateTime.tryParse(json['otpExpiry']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'adminName': adminName,
        'profilePhoto': profilePhoto,
        'createdAt': createdAt.toIso8601String(),
        'lastActiveAt': lastActiveAt?.toIso8601String(),
        'otp': otp,
        'otpExpiry': otpExpiry?.toIso8601String(),
      };
}

