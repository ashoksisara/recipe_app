import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/app/validation.dart';
import 'package:recipe_app/common/widgets/app_loader.dart';
import 'package:recipe_app/providers/authentication_provider.dart';

import '../../common/widgets/app_elevated_button.dart';
import '../../common/widgets/app_text_form_field.dart';
import '../sign_in/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthenticationProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: signUpFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 20),
                    AppTextFormField(
                      controller: authProvider.emailController,
                      hintText: 'Enter email',
                      validator: AppValidation.emailValidation,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    AppTextFormField(
                      controller: authProvider.passwordController,
                      hintText: 'Enter password',
                      obscureText: true,
                      validator: AppValidation.passwordValidation,
                    ),
                    const SizedBox(height: 20),
                    AppTextFormField(
                      controller: authProvider.confirmPasswordController,
                      hintText: 'Enter confirm password',
                      obscureText: true,
                      validator: (value) {
                        final password = authProvider.passwordController.text;
                        return AppValidation.confirmPasswordValidation(
                            value, password);
                      },
                    ),
                    const SizedBox(height: 40),
                    AppElevatedButton(
                      text: 'SIGN UP',
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (signUpFormKey.currentState!.validate()) {
                          context.read<AuthenticationProvider>().signUpUser(context);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: Theme.of(context).textTheme.bodyMedium
                            ),
                            TextSpan(
                              text: 'Sign in',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                FocusScope.of(context).unfocus();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const SignInScreen()));
                                },
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).primaryColor
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<AuthenticationProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const AppLoader();
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
