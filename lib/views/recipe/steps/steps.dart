import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_elevated_button.dart';

import '../../../providers/recipe_provider.dart';
import 'add_step.dart';

class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Steps'),
          const Text('Please add all steps'),
          Consumer<RecipeProvider>(builder: (context, provider, _) {
            if (provider.stepList.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: provider.stepList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(provider.stepList[index].name),
                    trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          provider.removeStep(provider.stepList[index]);
                        }),
                  );
                },
              );
            }
            return const SizedBox();
          }),
          const SizedBox(height: 20,),
          AppElevatedButton(
            text: 'Add step',
            textColor: Colors.white,
            buttonColor: Colors.blue,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddStep()));
            },
          ),
        ],
      ),
    );
  }
}
