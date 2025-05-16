import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:leo_rigging_dashboard/model/category_model.dart';
import 'package:leo_rigging_dashboard/model/crane_modal.dart';

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
  var cranes = <CraneModal>[].obs;
  ApiService apiService = ApiService();
  final RxBool isLoading = true.obs;
  RxBool isAspectRatioIssue = false.obs;
  var isSwitched = true.obs;

  var filteredCategory = <CategoryModel>[].obs;
  var filteredBrand = <BrandModel>[].obs;
  var filteredCrean = <CraneModal>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.text = "";
    selectedImage.value = null;
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    await Future.wait(
      [
        fetchAllBrand(),
         fetchAllCtegory(),
        fetchAllCrane()
      ]);
    filteredCategory.assignAll(category);
    filteredBrand.assignAll(brands);
    filteredCrean.assignAll(cranes);
  }

  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }

  void searchCategoryAndBrand(String query) {
    searchQuery.value = query.toLowerCase();
    if (query.isEmpty) {
      filteredBrand.assignAll(brands);
      filteredCategory.assignAll(category);
      filteredCrean.assignAll(cranes);
    } else {
      filteredCategory.assignAll(
        category.where((cat) {
          final categoryName = cat.categoryName.toLowerCase();
          return categoryName.contains(searchQuery.value);
        }).toList(),
      );
      filteredBrand.assignAll(
        brands.where((brd) {
          final brandName = brd.brandName.toLowerCase();
          return brandName.contains(searchQuery.value);
        }).toList(),
      );
      filteredCrean.assignAll(
        cranes.where((car) {
          final brandName = car.brand.brandName.toLowerCase();
          final categoryName = car.category.categoryName.toLowerCase();
          final modal = car.model.toLowerCase();
          final jib = car.jib.toLowerCase();
          return  brandName.contains(searchQuery.value) || categoryName.contains(searchQuery.value)|| modal.contains(searchQuery.value)||jib.contains(searchQuery.value);
        },).toList(),
        );
    }
  }

  Future<void> fetchAllBrand() async {
    final response = await apiService.get(ApiUrl.getAllBrand);
    brands.assignAll(
      (response['brands'] as List)
          .map((json) => BrandModel.fromJson(json))
          .toList(),
    );
    isLoading.value = false;
  }

  Future<void> fetchAllCtegory() async {
    final response = await apiService.get(ApiUrl.getAllCategory);
    category.assignAll(
      (response['categories'] as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList(),
    );
    filteredCategory.assignAll(category);
    isLoading.value = false;
  }

   

   Future<void> fetchAllCrane() async {
    final response = await apiService.get(ApiUrl.getAllCrane);
    cranes.assignAll(
      (response['cranes'] as List)
          .map((json) => CraneModal.fromJson(json))
          .toList(),
    );
    isLoading.value = false;
  }

  Future<void> uploadBrandAndCategory(
    bool isbrand,
    Map<String, String> name,
    Map<String, File> img,
  ) async {
    try {
      await apiService.postFormData(
        isbrand ? ApiUrl.postBrand : ApiUrl.postCategory,
        fields: name,
        files: img,
      );
    } catch (e) {
      Exception("Somting Went Wrong");
    } finally {
      selectedImage(null);
      nameController.text = "";
    }
  }

  Future<void> updateBrandAndCategory(
    bool isbrand,
    String id,
    Map<String, String>? name,
    Map<String, File>? img,
  ) async {
    try {
      if (img == null) {
        await apiService.putFormData(
          isbrand ? "${ApiUrl.editBrand}/$id" : "${ApiUrl.editCategory}/$id",
          fields: name,
        );
      } else {
        await apiService.putFormData(
          isbrand ? "${ApiUrl.editBrand}/$id" : "${ApiUrl.editCategory}/$id",
          fields: name,
          files: img,
        );
      }
    } catch (e) {
      Exception("Somting Went Wrong");
    } finally {
      selectedImage(null);
      nameController.text = "";
    }
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

  void handleUpdate(
    BuildContext context,
    String id,
    bool iscreate,
    bool isbrand,
  ) {
    final feilds =
        isbrand
            ? {'brandName': nameController.text}
            : {'categoryName': nameController.text};

    Map<String, File>? fileImage;
    if (selectedImage.value != null) {
      final file = File(selectedImage.value!.path);
      fileImage = isbrand ? {'imageUrl': file} : {'categoryimageUrl': file};
    } else {
      fileImage = null;
    }

    updateBrandAndCategory(isbrand, id, feilds, fileImage);

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
