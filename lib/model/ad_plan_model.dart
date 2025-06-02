import 'dart:convert';

class AdsPlanModel {
  final String id;
  final String title;
  final String description;
  final int minViews;
  final int maxViews;
  final String originalPrice;
  final String offerPrice;
  final String? badge;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdsPlanModel({
    required this.id,
    required this.title,
    required this.description,
    required this.minViews,
    required this.maxViews,
    required this.originalPrice,
    required this.offerPrice,
    required this.badge,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdsPlanModel.fromJson(Map<String, dynamic> json) {
    return AdsPlanModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      minViews: json['minViews'],
      maxViews: json['maxViews'],
      originalPrice: json['originalPrice'],
      offerPrice: json['offerPrice'],
      badge: json['badge'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static List<AdsPlanModel> fromJsonList(String jsonString) {
    final data = json.decode(jsonString);
    return List<AdsPlanModel>.from(data.map((item) => AdsPlanModel.fromJson(item)));
  }
}
