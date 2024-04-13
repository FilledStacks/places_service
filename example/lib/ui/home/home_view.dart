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
class HomeView extends StackedView<HomeViewModel> with $HomeView {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(context, model, child) => Scaffold(
        body: ListView(
          children: [
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
          ],
        ),
      );

  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    viewModel.initialise();
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
