
import 'package:leo_rigging_dashboard/model/brands_model.dart';
import 'package:leo_rigging_dashboard/model/category_model.dart';

class CraneModal {
  final String id;
  final String manufacturerName;
  final String model;
  final String brandId;
  final String? hour;
  final String categoryID;
  final String manufacturerYear;
  final String mainBoom;
  final String jib;
  final String counterWeight;
  final String slCounterWeight;
  final String liftingCapacity;
  final String? maxLiftingCapacity;
  final String? price;
  final List<String> imageUrl;
  final String serviceType;
  final String? description;
  final bool isverified;
  final bool isBlocked;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final List<dynamic> specifications;
  final BrandModel brand;
  final CategoryModel category;

  CraneModal({
    required this.id,
    required this.manufacturerName,
    required this.model,
    required this.brandId,
    required this.hour,
    required this.categoryID,
    required this.manufacturerYear,
    required this.mainBoom,
    required this.jib,
    required this.counterWeight,
    required this.slCounterWeight,
    required this.liftingCapacity,
    required this.maxLiftingCapacity,
    required this.price,
    required this.imageUrl,
    required this.serviceType,
    required this.description,
    required this.isverified,
    required this.isBlocked,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.specifications,
    required this.brand,
    required this.category,
  });

  factory CraneModal.fromJson(Map<String, dynamic> json) {
    return CraneModal(
      id: json['id'],
      manufacturerName: json['manufacturerName'],
      model: json['model'],
      brandId: json['brandId'],
      hour: json['hour'],
      categoryID: json['categoryID'],
      manufacturerYear: json['manufacturerYear'],
      mainBoom: json['mainBoom'],
      jib: json['jib'],
      counterWeight: json['counterWeight'],
      slCounterWeight: json['slCounterWeight'],
      liftingCapacity: json['liftingCapacity'],
      maxLiftingCapacity: json['maxLiftingCapacity'],
      price: json['price'],
      imageUrl: List<String>.from(json['imageUrl']),
      serviceType: json['serviceType'],
      description: json['description'],
      isverified: json['isverified'],
      isBlocked: json['isBlocked'],
      isAvailable: json['isAvailable'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
      specifications: json['specifications'],
      brand: BrandModel.fromJson(json['Brand']),
      category: CategoryModel.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'manufacturerName': manufacturerName,
        'model': model,
        'brandId': brandId,
        'hour': hour,
        'categoryID': categoryID,
        'manufacturerYear': manufacturerYear,
        'mainBoom': mainBoom,
        'jib': jib,
        'counterWeight': counterWeight,
        'slCounterWeight': slCounterWeight,
        'liftingCapacity': liftingCapacity,
        'maxLiftingCapacity': maxLiftingCapacity,
        'price': price,
        'imageUrl': imageUrl,
        'serviceType': serviceType,
        'description': description,
        'isverified': isverified,
        'isBlocked': isBlocked,
        'isAvailable': isAvailable,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'userId': userId,
        'specifications': specifications,
        'Brand': brand.toJson(),
        'category': category.toJson(),
      };
}

