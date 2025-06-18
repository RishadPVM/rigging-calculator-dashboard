import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leo_rigging_dashboard/model/brands_model.dart';
import 'package:leo_rigging_dashboard/model/category_model.dart';
import 'package:leo_rigging_dashboard/model/crane_enquiry.dart';
import 'package:leo_rigging_dashboard/model/crane_modal.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/api/api_service.dart';
import '../../../core/api/api_url.dart';

class CraneController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final RxBool showAddButton = false.obs;
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var category = <CategoryModel>[].obs;
  var brands = <BrandModel>[].obs;
  var craneEnquiry = <CraneEnquiryModel>[].obs;
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
    await Future.wait([fetchAllBrand(), fetchAllCtegory(), fetchAllCrane()]);
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
        category.where(
          (cat) => cat.categoryName.toLowerCase().contains(searchQuery.value),
        ),
      );
      filteredBrand.assignAll(
        brands.where(
          (brd) => brd.brandName.toLowerCase().contains(searchQuery.value),
        ),
      );
      filteredCrean.assignAll(
        cranes.where((car) {
          final brandName = car.brand.brandName.toLowerCase();
          final categoryName = car.category.categoryName.toLowerCase();
          final modal = car.model.toLowerCase();
          final jib = car.jib.toLowerCase();
          return brandName.contains(searchQuery.value) ||
              categoryName.contains(searchQuery.value) ||
              modal.contains(searchQuery.value) ||
              jib.contains(searchQuery.value);
        }),
      );
    }
  }

  Future<void> fetchCraneEnquiry(String id) async {
    final response = await apiService.get("${ApiUrl.getAllCraneEnuiry}/$id");
    craneEnquiry.assignAll(
      (response['inquiry'] as List)
          .map((json) => CraneEnquiryModel.fromJson(json))
          .toList(),
    );
    isLoading.value = false;
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
      throw Exception("Something went wrong");
    } finally {
      selectedImage.value = null;
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
      await apiService.putFormData(
        isbrand ? "${ApiUrl.editBrand}/$id" : "${ApiUrl.editCategory}/$id",
        fields: name,
        files: img,
      );
    } catch (e) {
      throw Exception("Something went wrong");
    } finally {
      selectedImage.value = null;
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

  Future<void> pickAndCropImage(BuildContext context, bool isBrand) async {
    final double requiredAspectRatio = isBrand ? 2.35 / 1 : 1 / 1;
    isAspectRatioIssue.value = false;
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => CropImageScreen(
                image: image,
                requiredAspectRatio: requiredAspectRatio,
                controller: this,
              ),
        ),
      );
    } catch (e) {
      isAspectRatioIssue.value = false;
      if (!Get.isSnackbarOpen) {
        Get.snackbar('Error', 'Unable to process image');
      }
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

    final fields =
        isbrand
            ? {'brandName': nameController.text}
            : {'categoryName': nameController.text};

    final file = File(selectedImage.value!.path);
    final fileImage = isbrand ? {'imageUrl': file} : {'categoryimageUrl': file};

    uploadBrandAndCategory(isbrand, fields, fileImage);
    fetchAllData();
    Navigator.of(context).pop();
  }

  void handleUpdate(
    BuildContext context,
    String id,
    bool iscreate,
    bool isbrand,
  ) {
    final fields =
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

    updateBrandAndCategory(isbrand, id, fields, fileImage);
    fetchAllData();
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

class CropImageScreen extends StatelessWidget {
  final XFile image;
  final double requiredAspectRatio;
  final CraneController controller;

  const CropImageScreen({
    super.key,
    required this.image,
    required this.requiredAspectRatio,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final CropController cropController = CropController();
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Image"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              cropController.crop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: File(image.path).readAsBytes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text("Error loading image"));
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final size =
                    constraints.maxWidth < constraints.maxHeight
                        ? constraints.maxWidth * 0.8
                        : constraints.maxHeight * 0.8;

                return SizedBox(
                  width: size,
                  height: size,
                  child: Crop(
                    controller: cropController,
                    image: snapshot.data!,
                    aspectRatio: requiredAspectRatio,
                    onCropped: (CropResult result) async {
                      switch (result) {
                        case CropSuccess(:final croppedImage):
                          await _handleCroppedBytes(croppedImage, navigator);
                          break;

                        case CropFailure(:final cause):
                          if (!Get.isSnackbarOpen) {
                            Get.snackbar(
                              'Error',
                              'Crop failed: $cause',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                          break;
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleCroppedBytes(
    Uint8List croppedBytes,
    NavigatorState navigator,
  ) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
        '${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await tempFile.writeAsBytes(croppedBytes);
      controller.selectedImage.value = XFile(tempFile.path);
      controller.isAspectRatioIssue.value = false;
      navigator.pop();
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          'Error',
          'Failed to save cropped image: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
