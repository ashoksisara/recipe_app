import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppImageSelection extends StatelessWidget {
  final XFile? file;

  const AppImageSelection({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5)
      ),
      child: file != null
          ? Image.file(
              File(file!.path),
              fit: BoxFit.cover,
            )
          : const Icon(
              Icons.camera_alt,
              size: 60,
            ),
    );
  }
}
