# Places Service

The **Places Service** is a Dart library that simplifies interaction with the **Google Places API** by wrapping it through the `google_maps_webservice` package. It provides an easy-to-use interface for fetching auto-complete suggestions, place details, and nearby places based on the user's current location.

---

## Features

- **Auto-complete Suggestions**: Get a list of address suggestions based on user input.
- **Place Details**: Fetch detailed information about a specific place using its `placeId`.
- **Nearby Places**: Retrieve a list of places near the user's current location.
- **Session Management**: Automatically manages session tokens for API requests.

---

## Installation

Add the `places_service` library to your `pubspec.yaml` file:

```yaml
dependencies:
  places_service: ^1.0.0
```

---

## Usage

### 1. Initialize the Service

Before using the service, you must initialize it with your Google Places API key.

```dart
_placesService.initialize(
  apiKey: 'YOUR_GOOGLE_PLACES_API_KEY',
);
```

If you're following the **FilledStacks** recommended setup, this can be done in the `StartUpViewModel`.

---

### 2. Get Auto-complete Suggestions

To fetch address suggestions based on user input, use the `getAutoComplete` method.

```dart
final autoCompleteSuggestions = await _placesService.getAutoComplete('cape town');
```

This returns a list of `PlacesAutoCompleteResult` objects containing:

- `placeId`
- `description`
- `mainText`
- `secondaryText`

---

### 3. Get Place Details

Once you have a `placeId` from the auto-complete results, you can fetch detailed information about the place using the `getPlaceDetails` method.

```dart
final placeDetails = await _placesService.getPlaceDetails('ID_FROM_AUTO_COMPLETE');
```

This returns a `PlacesDetails` object containing:

- `streetNumber`
- `streetShort`
- `streetLong`
- `city`
- `state`
- `zip`
- `lat` (latitude)
- `lng` (longitude)
- `searchString` (formatted address)

---

### 4. Get Nearby Places

To fetch a list of places near the user's current location, use the `getPlacesAtCurrentLocation` method.

```dart
final nearbyPlaces = await _placesService.getPlacesAtCurrentLocation();
```

This returns a list of `PlacesLocation` objects containing:

- `id`
- `latitude`
- `longitude`
- `placeName`

---

## Error Handling

The service throws a `PlacesApiException` if any issues occur during API requests. You can catch and handle these exceptions in your code.

```dart
try {
  final suggestions = await _placesService.getAutoComplete('new york');
} catch (e) {
  print('Error: ${e.toString()}');
}
```

---

## Example

Here’s a complete example of how to use the Places Service:

```dart
void main() async {
  final placesService = PlacesService();

  // Initialize with your API key
  placesService.initialize(apiKey: 'YOUR_GOOGLE_PLACES_API_KEY');

  // Get auto-complete suggestions
  final suggestions = await placesService.getAutoComplete('new york');
  print('Suggestions: $suggestions');

  // Get place details
  if (suggestions.isNotEmpty) {
    final placeId = suggestions.first.placeId;
    final details = await placesService.getPlaceDetails(placeId);
    print('Place Details: $details');
  }

  // Get nearby places
  final nearbyPlaces = await placesService.getPlacesAtCurrentLocation();
  print('Nearby Places: $nearbyPlaces');
}
```

---

## Notes

- Ensure you have enabled the **Google Places API** in your Google Cloud Console.
- The service automatically generates and manages session tokens for API requests.
- For location-based features, ensure your app has the necessary permissions to access the device's location.

---

## License

This library is provided under the MIT License. See the `LICENSE` file for more details.

---

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on the [GitHub repository](https://github.com/FilledStacks/places_service).

---

Enjoy using the **Places Service**! 🚀
