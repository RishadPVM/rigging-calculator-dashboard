class SponsorAdModel {
  final String id;
  final String sponsorId;
  final String title;
  final String image;
  final String webUrl;
  final DateTime createdAt;
  final bool isActive;

  SponsorAdModel({
    required this.id,
    required this.sponsorId,
    required this.title,
    required this.image,
    required this.webUrl,
    required this.createdAt,
    required this.isActive,
  });

  factory SponsorAdModel.fromJson(Map<String, dynamic> json) {
    return SponsorAdModel(
      id: json['id'],
      sponsorId: json['sponsorId'],
      title: json['title'],
      image: json['image'],
      webUrl: json['webUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'],
    );
  }}