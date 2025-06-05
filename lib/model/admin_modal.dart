class AdminModel {
  final String id;
  final String email;
  final String adminName;
  final String? profilePhoto;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final String type;

  AdminModel({
    required this.id,
    required this.email,
    required this.adminName,
    this.profilePhoto,
    required this.createdAt,
    this.lastActiveAt,
    required this.type,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      email: json['email'],
      adminName: json['adminName'],
      profilePhoto: json['profilePhoto'],
      createdAt: DateTime.parse(json['createdAt']),
      lastActiveAt: json['lastActiveAt'] != null ? DateTime.tryParse(json['lastActiveAt']) : null,
      type: json['type'],
    );
  }
}
