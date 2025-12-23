import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? image;
  final Function(ImageSource) onPick;

  const ProfileImagePicker({
    super.key,
    required this.image,
    required this.onPick,
  });

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              onPick(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              onPick(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showSheet(context),
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white, width: 3.5),
        ),
        child: image == null
            ? const Center(
                child: Icon(Icons.add_a_photo,
                    color: AppColors.darkTeal, size: 30),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.file(image!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
