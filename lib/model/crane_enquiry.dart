class CraneEnquiryModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String message;
  final String craneId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  CraneEnquiryModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.message,
    required this.craneId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CraneEnquiryModel.fromJson(Map<String, dynamic> json) {
    return CraneEnquiryModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      message: json['message'],
      craneId: json['craneId'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'message': message,
      'craneId': craneId,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
