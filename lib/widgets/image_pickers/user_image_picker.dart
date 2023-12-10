import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(XFile) onImageSelected;

  const UserImagePicker({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade400,
          backgroundImage: _selectedImage == null
              ? null
              : FileImage(
                  File(_selectedImage!.path),
                ),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(
            Icons.image,
          ),
          label: const Text(
            'Add Image',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      _selectedImage = image;
    });

    if (image != null) {
      widget.onImageSelected(image);
    }
  }
}
