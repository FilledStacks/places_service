import 'package:places_example/app/app.locator.dart';
import 'package:places_service/places_service.dart';
import 'package:stacked/stacked.dart';

import 'home_view.form.dart';

class HomeViewModel extends FormViewModel {
  final _placesService = locator<PlacesService>();

  List<PlacesAutoCompleteResult> _autoCompleteResults = [];

  List<PlacesAutoCompleteResult> get autoCompleteResults =>
      _autoCompleteResults;

  bool get hasAutoCompleteResults => _autoCompleteResults.isNotEmpty;

  void initialise() {
    _placesService.initialize(
      apiKey: 'PUT_YOUR_KEY_HERE',
    );
  }

  @override
  void setFormStatus() {
    // Fire and forget since debounce will take care of the cancelling
    _getAutoCompleteResults();
  }

  Future<void> _getAutoCompleteResults() async {
    if (addressValue != null) {
      final placesResults =
          await runBusyFuture(_placesService.getAutoComplete(addressValue!));
      print(placesResults);

      if (placesResults != null) {
        _autoCompleteResults = placesResults;
      }

      notifyListeners();
    }
  }
}
