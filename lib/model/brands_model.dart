class BrandModel {
  final String id;
  final String brandName;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  BrandModel({
    required this.id,
    required this.brandName,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as String,
      brandName: json['brandName'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandName': brandName,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
