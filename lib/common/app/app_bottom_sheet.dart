import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppBottomSheet{
  //common app image selection sheet
  static void showImageSelectionSheet(BuildContext context,
      {required Function(XFile?) onCamera, required Function(XFile?) onGallery}){
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 160,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(onPressed: () async {
                      try {
                        final XFile? file = await picker.pickImage(source: ImageSource.camera);
                        onCamera.call(file);
                      } catch (e) {
                        debugPrint('$e');
                      }
                    }, child: const Text('Camera')),
                const Divider(),
                TextButton(onPressed: () async{
                  try {
                    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                    onGallery.call(file);
                  } catch (e) {
                    debugPrint('$e');
                  }
                }, child: const Text('Gallery'))
              ],
            ),
          ),
        );
      },
    );
  }
}