import 'package:leo_rigging_dashboard/model/admin_modal.dart';

class LoginResponse {
  final bool status;
  final AdminModel admin;
  final String token;

  LoginResponse({
    required this.status,
    required this.admin,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['success']??false,
      admin: AdminModel.fromJson(json['admin']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'admin': admin.toJson(),
      'token': token,
    };
  }
}
