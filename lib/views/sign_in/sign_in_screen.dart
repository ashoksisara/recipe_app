import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/app/validation.dart';
import 'package:recipe_app/providers/authentication_provider.dart';

import '../../common/widgets/app_elevated_button.dart';
import '../../common/widgets/app_loader.dart';
import '../../common/widgets/app_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthenticationProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recipe App'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: signInFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Sign In',
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
                  const SizedBox(height: 40),
                  AppElevatedButton(
                    text: 'SIGN IN',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if(signInFormKey.currentState!.validate()){
                        context.read<AuthenticationProvider>().signInUser(context);
                      }
                    },
                  ),
                ],
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
          ),
        ],
      ),
    );
  }
}
