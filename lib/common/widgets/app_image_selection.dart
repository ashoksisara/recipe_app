import 'package:flutter/material.dart';


class AppImageSelection extends StatelessWidget {
  const AppImageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.white,
      child: const Icon(
        Icons.camera_alt,
        size: 60,
      ),
    );
  }
}
