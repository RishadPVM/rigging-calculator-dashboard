import 'package:leo_rigging_dashboard/model/user_model.dart';

class AdModel {
  final String id;
  final String sponsorId;
  final String title;
  final String image;
  final String webUrl;
  final DateTime createdAt;
  final bool isActive;
  final List<ClickUser> clickUsers;
  final List<ReadUser> readUsers;

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
          .map((e) => ClickUser.fromJson(e))
          .toList(),
      readUsers: (json['readUsers'] as List)
          .map((e) => ReadUser.fromJson(e))
          .toList(),
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
      'readUsers': readUsers.map((e) => e.toJson()).toList(),
    };
  }
}

class ClickUser {
  final String userId;
  final String sponsorAdId;
  final DateTime clickAt;
  final UserModel user;

  ClickUser({
    required this.userId,
    required this.sponsorAdId,
    required this.clickAt,
    required this.user,
  });

  factory ClickUser.fromJson(Map<String, dynamic> json) {
    return ClickUser(
      userId: json['userId'],
      sponsorAdId: json['sponsorAdId'],
      clickAt: DateTime.parse(json['clickAt']),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'sponsorAdId': sponsorAdId,
      'clickAt': clickAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

class ReadUser {
  final String userId;
  final String sponsorAdId;
  final DateTime readAt;
  final UserModel user;

  ReadUser({
    required this.userId,
    required this.sponsorAdId,
    required this.readAt,
    required this.user,
  });

  factory ReadUser.fromJson(Map<String, dynamic> json) {
    return ReadUser(
      userId: json['userId'],
      sponsorAdId: json['sponsorAdId'],
      readAt: DateTime.parse(json['readAt']),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'sponsorAdId': sponsorAdId,
      'readAt': readAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

