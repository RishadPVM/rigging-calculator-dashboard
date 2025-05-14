import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:leo_rigging_dashboard/model/category_model.dart';

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
  RxBool isAspectRatioIssue = false.obs;

  @override
  void onInit() {
    super.onInit();
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

  Future<void> uploadBrandAndCategory(
    bool isbrand,
    Map<String, String> name,
    Map<String, File> img,
  ) async {
    await apiService.postFormData(
      isbrand ? ApiUrl.postBrand : ApiUrl.postCategory,
      fields: name,
      files: img,
    );
  }
  Future<void> updateBrandAndCategory(
    bool isbrand,
    String id,
    Map<String, String> name,
    Map<String, File> img,
  ) async {
    await apiService.postFormData(
      isbrand ?  "${ApiUrl.editBrand}/$id" : "${ApiUrl.editCategory}/$id",
      fields: name,
      files: img,
    );
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

  Future<void> pickAndValidateImage(bool isBrand) async {
    final double aspectRatio = isBrand ? 2.35 / 1 : 1 / 1;
    isAspectRatioIssue(false);
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final bytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) {
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Error', 'Unable to process image');
        }
        return;
      }

      final currentAspectRatio = decodedImage.width / decodedImage.height;

      if ((currentAspectRatio - aspectRatio).abs() > 0.05) {
        isAspectRatioIssue(true);
        return;
      }

      selectedImage.value = image;
    } catch (e) {
      isAspectRatioIssue(false);
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

    final feilds =
        isbrand
            ? {'brandName': nameController.text}
            : {'categoryName': nameController.text};

    final file = File(selectedImage.value!.path);
    final fileImage = isbrand ? {'imageUrl': file} : {'categoryimageUrl': file};
    uploadBrandAndCategory(isbrand, feilds, fileImage);
    fetchAllCtegory();

    Navigator.of(context).pop();
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
