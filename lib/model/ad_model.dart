import 'user_model.dart';

class AdModel {
  final String id;
  final String sponsorId;
  final String title;
  final String image;
  final String webUrl;
  final DateTime createdAt;
  final bool isActive;
  final List<ClickUserModel> clickUsers;
  final List<dynamic> readUsers;

  AdModel({
    required this.id,
    required this.sponsorId,
    required this.title,
    required this.image,
    required this.webUrl,
    required this.createdAt,
    required this.isActive,
    required this.clickUsers,
    required this.readUsers,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      sponsorId: json['sponsorId'],
      title: json['title'],
      image: json['image'],
      webUrl: json['webUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'],
      clickUsers: (json['clickUsers'] as List)
          .map((e) => ClickUserModel.fromJson(e))
          .toList(),
      readUsers: json['readUsers'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sponsorId': sponsorId,
      'title': title,
      'image': image,
      'webUrl': webUrl,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
      'clickUsers': clickUsers.map((e) => e.toJson()).toList(),
      'readUsers': readUsers,
    };
  }
}

class ClickUserModel {
  final String id;
  final String userId;
  final String sponsorAdId;
  final DateTime clickAt;
  final UserModel user;

  ClickUserModel({
    required this.id,
    required this.userId,
    required this.sponsorAdId,
    required this.clickAt,
    required this.user,
  });

  factory ClickUserModel.fromJson(Map<String, dynamic> json) {
    return ClickUserModel(
      id: json['id'],
      userId: json['userId'],
      sponsorAdId: json['sponsorAdId'],
      clickAt: DateTime.parse(json['clickAt']),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'sponsorAdId': sponsorAdId,
      'clickAt': clickAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}


