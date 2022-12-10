import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_image_selection.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

import '../../../common/app/validation.dart';
import '../../../common/widgets/app_elevated_button.dart';
import '../../../common/widgets/app_text_form_field.dart';
import '../../../model/step_model.dart';

class AddStep extends StatelessWidget {
  AddStep({Key? key}) : super(key: key);
  final TextEditingController instructionController = TextEditingController();
  final TextEditingController stepNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final stepFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add ingredient',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: stepFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppImageSelection(),
              const SizedBox(
                height: 20,
              ),
              const Text('Step name'),
              AppTextFormField(
                  controller: stepNameController,
                  hintText: 'Enter step name',
                  validator: Validation.fieldEmptyValidation,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Instruction'),
              AppTextFormField(
                  controller: instructionController,
                  hintText: 'Write instruction for this step',
                validator: Validation.fieldEmptyValidation,
              ),
              const SizedBox(
                height: 40,
              ),
              AppElevatedButton(
                text: 'Save',
                textColor: Colors.white,
                buttonColor: Colors.blue,
                onPressed: () {
                  if(stepFormKey.currentState!.validate()){
                    StepModel step = StepModel(
                        instruction: instructionController.text,
                        name: stepNameController.text,
                        photo: '');
                    context.read<RecipeProvider>().addStep(step);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
