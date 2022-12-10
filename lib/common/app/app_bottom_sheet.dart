import 'package:flutter/material.dart';

class AppBottomSheet{
  static void showImageSelectionSheet(BuildContext context){
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
                TextButton(onPressed: (){

                }, child: const Text('Camera')),
                const Divider(),
                TextButton(onPressed: (){}, child: const Text('Gallery'))
              ],
            ),
          ),
        );
      },
    );
  }
}