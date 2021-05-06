import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'home_view.form.dart';
import 'home_viewmodel.dart';

@FormView(fields: [
  FormTextField(
    name: 'address',
  )
])
class HomeView extends StatelessWidget with $HomeView {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) async {
        model.initialise();
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => Scaffold(
        body: ListView(children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter your address'),
            controller: addressController,
          ),
          if (model.isBusy) Align(child: CircularProgressIndicator()),
          if (!model.isBusy && !model.hasAutoCompleteResults)
            Text('We have no suggestions for you, change the address above.'),
          if (!model.isBusy && model.hasAutoCompleteResults)
            ...model.autoCompleteResults.map((autoCompleteResult) => ListTile(
                  title: Text(autoCompleteResult.mainText ?? ''),
                  subtitle: Text(autoCompleteResult.secondaryText ?? ''),
                ))
        ]),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
