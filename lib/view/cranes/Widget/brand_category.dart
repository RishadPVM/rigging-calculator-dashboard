import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../../../utils/appcolors.dart';
import '../../../widget/c_textfeild.dart';

class BrandCategoryDialoge extends StatefulWidget {
  final String? image;
  final String? name;
  final bool iscreate;
  final bool isbrand;

  const BrandCategoryDialoge({
    super.key,
    this.image,
    this.name,
    required this.iscreate,
    required this.isbrand,
  });

  @override
  State<BrandCategoryDialoge> createState() => _BrandCategoryDialogeState();
}

class _BrandCategoryDialogeState extends State<BrandCategoryDialoge> {
  late TextEditingController _nameController;
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final double _requiredAspectRatio = 25 / 14;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.iscreate ? "" : widget.name,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickAndValidateImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // Read image and check aspect ratio
      final bytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) {
        _showError('Unable to process image');
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

      setState(() {
        _selectedImage = processedImage;
      });
    } catch (e) {
      _showError('Error processing image: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _handleSubmit() {
    if (_nameController.text.isEmpty) {
      _showError('Please enter a name');
      return;
    }

    if (widget.iscreate && _selectedImage == null) {
      _showError('Please select an image');
      return;
    }

    final result = {
      'name': _nameController.text,
      'image': _selectedImage?.path ?? widget.image,
      'isBrand': widget.isbrand,
    };

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.isbrand
                ? widget.iscreate
                    ? "Create Brand"
                    : "Edit Brand"
                : widget.iscreate
                    ? "Create Category"
                    : "Edit Category",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _pickAndValidateImage,
              child: Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.cGrey300,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color.fromARGB(255, 213, 213, 213),
                  ),
                ),
                child: _selectedImage != null
                    ? AspectRatio(
                        aspectRatio: _requiredAspectRatio,
                        child: Image.file(
                          File(_selectedImage!.path),
                          fit: BoxFit.contain,
                        ),
                      )
                    : widget.iscreate
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_a_photo_outlined),
                              const SizedBox(height: 8),
                              Text(
                                "Upload Image (Aspect Ratio 25:14)",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        : widget.image != null
                            ? AspectRatio(
                                aspectRatio: _requiredAspectRatio,
                                child: Image.asset(
                                  widget.image!,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
            const SizedBox(height: 8),
            CTextField(
              labelText: widget.isbrand ? "Brand name" : "Category name",
              suffixIcon: Icons.abc_outlined,
              controller: _nameController,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _handleSubmit,
          child: Text(widget.iscreate ? "Create" : "Update"),
        ),
      ],
    );
  }
}