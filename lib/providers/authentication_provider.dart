import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/services/firebase_service/firebase_service.dart';
import 'package:recipe_app/views/sign_in/sign_in_screen.dart';

import '../common/app/app_snack_bar.dart';
import '../home_screen.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> signUpUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    FirebaseService.signUpUser(context, email, password)
        .then((UserCredential? userCredential) {
      isLoading = false;
      notifyListeners();
      if (userCredential != null) {
        AppSnackBar.showSnackBar(context, 'Sign up successfully!');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ));
      }
    });
  }

  Future<void> signInUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    FirebaseService.signInUser(context, email, password)
        .then((UserCredential? userCredential) {
      debugPrint('sign in userCredential $userCredential');
      isLoading = false;
      notifyListeners();
      if (userCredential != null) {
        AppSnackBar.showSnackBar(context, 'Sign in successfully!');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      }
    });
  }
}