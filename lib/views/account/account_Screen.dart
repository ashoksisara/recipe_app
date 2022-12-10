import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/app/app_alert_dialog.dart';
import 'package:recipe_app/providers/authentication_provider.dart';

import '../../common/widgets/app_elevated_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          children: [
            AppElevatedButton(
              text: 'Log out',
              onPressed: () {
                AppAlertDialog.showAlertDialog(context,
                    alertMessage: 'Are you sure you want to sign out?',
                    button1Text: 'No',
                    button2Text: 'Yes',
                    onTapButton1: Navigator.of(context).pop, onTapButton2: () {
                  context.read<AuthenticationProvider>().signOutUser();
                  SystemNavigator.pop();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
