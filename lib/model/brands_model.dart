class BrandModel {
  final String id;
  final String brandName;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  BrandModel({
    required this.id,
    required this.brandName,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      brandName: json['brandName'],
      image: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}