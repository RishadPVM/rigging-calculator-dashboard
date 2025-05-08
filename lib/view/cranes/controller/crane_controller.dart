import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:leo_rigging_dashboard/model/category_model.dart';
import 'dart:io';

import '../../../core/api/api_service.dart';
import '../../../core/api/api_url.dart';
import '../../../model/brands_model.dart';

class CraneController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final RxBool showAddButton = false.obs;
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var category = <CategoryModel>[].obs;
  var brands = <BrandModel>[].obs;
  ApiService apiService = ApiService();
  final RxBool isLoading = true.obs;
  final double _requiredAspectRatio = 25 / 14;

  @override
  void onInit() {
    super.onInit();
    // Reset controller state when dialog opens for create mode
    nameController.text = "";
    selectedImage.value = null;
    fetchAllBrand();
    fetchAllCtegory();
  }

   Future<void> fetchAllBrand() async {
    final response = await apiService.get(ApiUrl.getAllBrand);
    brands.assignAll(
      (response['brands'] as List)
          .map((json) => BrandModel.fromJson(json))
          .toList(),
    );
    log('fetched: ${category.length}');
    isLoading.value = false;
  }

  Future<void> fetchAllCtegory() async {
    final response = await apiService.get(ApiUrl.getAllCategory);
    category.assignAll(
      (response['categories'] as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList(),
    );
    log('fetched: ${category.length}');
    isLoading.value = false;
  }

  void updateTabIndex(int index) {
    tabIndex.value = index;
    showAddButton.value = index == 1 || index == 2;
  }

  void resetDialogState() {
    nameController.text = "";
    selectedImage.value = null;
  }

  Future<void> pickAndValidateImage(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // Read image and check aspect ratio
      final bytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) {
        _showError(context, 'Unable to process image');
        return;
      }

      final currentAspectRatio = decodedImage.width / decodedImage.height;
      XFile? processedImage = image;

      // Check if aspect ratio is within 5% of required 25:14
      if ((currentAspectRatio - _requiredAspectRatio).abs() > 0.05) {
        // Crop image to 25:14
        final targetWidth = decodedImage.height * _requiredAspectRatio;
        final cropX = (decodedImage.width - targetWidth) / 2;
        final croppedImage = img.copyCrop(
          decodedImage,
          x: cropX.round(),
          y: 0,
          width: targetWidth.round(),
          height: decodedImage.height,
        );

        // Save cropped image to temporary file
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/cropped_${image.name}');
        await tempFile.writeAsBytes(img.encodePng(croppedImage));
        processedImage = XFile(tempFile.path);
      }

      selectedImage.value = processedImage;
    } catch (e) {
      _showError(context, 'Error processing image: $e');
    }
  }

  void handleSubmit(
    BuildContext context,
    bool iscreate,
    bool isbrand,
    String? existingImage,
  ) {
    if (nameController.text.isEmpty) {
      _showError(context, 'Please enter a name');
      return;
    }

    if (iscreate && selectedImage.value == null) {
      _showError(context, 'Please select an image');
      return;
    }

    final result = {
      'name': nameController.text,
      'image': selectedImage.value?.path ?? existingImage,
      'isBrand': isbrand,
    };

    Navigator.of(context).pop(result);
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
