import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_image_selection.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

import '../../../common/app/app_bottom_sheet.dart';
import '../../../common/app/validation.dart';
import '../../../common/widgets/app_elevated_button.dart';
import '../../../common/widgets/app_text_form_field.dart';
import '../../../model/step_model.dart';

class AddStep extends StatefulWidget {
  const AddStep({Key? key}) : super(key: key);

  @override
  State<AddStep> createState() => _AddStepState();
}

class _AddStepState extends State<AddStep> {
  final TextEditingController instructionController = TextEditingController();

  final TextEditingController stepNameController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final stepFormKey = GlobalKey<FormState>();

  XFile? stepImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add step',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: stepFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    AppBottomSheet.showImageSelectionSheet(context,
                        onCamera: (file) {
                          debugPrint('file ---> ${file?.name}');
                          setState((){stepImage = file;});
                          Navigator.of(context).pop();
                        }, onGallery: (file) {
                          debugPrint('file ---> ${file?.name}');
                          setState((){stepImage = file;});
                          Navigator.of(context).pop();
                        });
                  },
                  child : AppImageSelection(file: stepImage,),),
                const SizedBox(
                  height: 20,
                ),
                Text('Step name',style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 10,
                ),
                AppTextFormField(
                    controller: stepNameController,
                    hintText: 'Enter step name',
                    validator: AppValidation.fieldEmptyValidation,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Instruction',style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 10,
                ),
                AppTextFormField(
                    controller: instructionController,
                    hintText: 'Write instruction for this step',
                  validator: AppValidation.fieldEmptyValidation,
                ),
                const SizedBox(
                  height: 40,
                ),
                AppElevatedButton(
                  text: 'Save',
                  onPressed: () {
                    if(stepFormKey.currentState!.validate()){
                      StepModel step = StepModel(
                          instruction: instructionController.text,
                          name: stepNameController.text,
                          image: stepImage,
                          imageUrl: ''
                      );
                      context.read<RecipeProvider>().addStep(step);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
