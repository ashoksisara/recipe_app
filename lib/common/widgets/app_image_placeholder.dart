import 'package:flutter/material.dart';

class AppImagePlaceHolder extends StatelessWidget {
  const AppImagePlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.purple, borderRadius: BorderRadius.circular(10)),
      child: const Text('No image',
          style: TextStyle(color: Colors.white, fontSize: 10),
          maxLines: 2,
          textAlign: TextAlign.center),
    );
  }
}
