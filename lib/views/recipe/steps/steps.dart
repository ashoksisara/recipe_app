import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_elevated_button.dart';

import '../../../common/widgets/app_image_placeholder.dart';
import '../../../providers/recipe_provider.dart';
import 'add_step.dart';

class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text('Steps',style: Theme.of(context).textTheme.titleMedium),
           Text('Please add all steps',style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 20,),
            Consumer<RecipeProvider>(builder: (context, provider, _) {
              if (provider.stepList.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.stepList.length,
                  itemBuilder: (context, index) {
                    final step = provider.stepList[index];
                    return ListTile(
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: step.image != null ? Image.file(
                            File(step.image!.path),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const AppImagePlaceHolder();
                            },
                          ) : const AppImagePlaceHolder(),
                        ),
                      ),
                      title: Text(step.name,maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(step.instruction,maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            provider.removeStep(step);
                          }),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 20,);
                },
                );
              }
              return const SizedBox();
            }),
            const SizedBox(height: 20,),
            AppElevatedButton(
              text: 'Add step',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddStep()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
