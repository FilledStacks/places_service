# Places Service

A service that Wraps the Google places Api through the google_maps_webservice package and provides an easy interface to work with and handle in your code.

## How To use

### Initialise

To start off you have to call initialise an pass in your api key

```dart
   _placesService.initialize(
      apiKey: 'PUT_YOUR_KEY_HERE',
    );
```

If you're using the setup recommended by FilledStacks this can be done in the `StartUpViewModel`. 

### Get Automcomplete Suggestions

When this is complete you can get your Suggestions for an address using the `getAutoComplete` function.

```dart
final autoCompleteSuggestions = await _placesService.getAutoComplete('cape town');
```

That will return a list of auto complete suggestions to you.

### Get Places Details

Once you have the places id you want to get you can make a request to `getPlaceDetails` to get all the details google has available for that place. 

```dart
final placeDetails = await _placesService.getPlaceDetails('ID_FROM_AUTO_COMPLETE');
```

