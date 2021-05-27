library places_service;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

import 'models/application_models.dart';

class PlacesService {
  final _uuid = Uuid();

  GoogleMapsPlaces? _places;

  late PlacesLocation _currentPosition;
  String? _sessionToken;
  bool _resetSessionTokenForNextAutoComplete = false;

  PlacesLocation get currentPosition => _currentPosition;

  /// Returns the session token last used to get auto-complete results from the
  /// Places API
  String? get sessionToken => _sessionToken;

  /// Must initialize and pass in an API key.
  void initialize({required String apiKey}) {
    _places = GoogleMapsPlaces(
      apiKey: apiKey,
    );
  }

  /// Gets auto complete results from the GoogleMapsApi
  ///
  /// Returns List of [PlacesAutoCompleteResult] or a [String] for a friendly error message
  Future<List<PlacesAutoCompleteResult>> getAutoComplete(String input) async {
    if (_sessionToken == null || _resetSessionTokenForNextAutoComplete) {
      // Set reset back to false. We only want a new session when the user has selected`
      // a place. Which for us means getPlaceDetails has been called.
      _resetSessionTokenForNextAutoComplete = false;

      // Generate a new session token
      _sessionToken = _uuid.v4();
    }

    return _runPlacesRequest<List<PlacesAutoCompleteResult>,
        PlacesAutocompleteResponse>(
      placesRequest: _places!.autocomplete(input, sessionToken: _sessionToken),
      serialiseResponse: (autoCompleteResults) {
        final results = autoCompleteResults.predictions.where((prediction) {
          final address =
              prediction.structuredFormatting?.mainText.split(' ').first;
          return address != null;
        }).map((prediction) {
          return PlacesAutoCompleteResult(
            placeId: prediction.placeId,
            description: prediction.description,
            mainText: prediction.structuredFormatting?.mainText,
            secondaryText: prediction.structuredFormatting?.secondaryText,
          );
        });
        return results.toList();
      },
      warningMessageForNotOkayResult: 'Could not get places from Google Maps',
    );
  }

  /// Returns the [PlacesDetails] associated with the placeId
  Future<PlacesDetails> getPlaceDetails(String placeId) async {
    return _runPlacesRequest<PlacesDetails, PlacesDetailsResponse>(
      placesRequest:
          _places!.getDetailsByPlaceId(placeId, sessionToken: _sessionToken),
      serialiseResponse: (detailsResponse) {
        // Indicate token reset on next auto complete request
        _resetSessionTokenForNextAutoComplete = true;

        var details = detailsResponse.result;
        var streetNumber = _getShortNameFromComponent(details, 'street_number');
        var streetShort = _getShortNameFromComponent(details, 'route');
        var city = _getShortNameFromComponent(details, 'locality');
        var state =
            _getShortNameFromComponent(details, 'administrative_area_level_1');

        return PlacesDetails(
          placeId: placeId,
          streetNumber: streetNumber,
          streetShort: streetShort,
          streetLong: _getLongNameFromComponent(details, 'route'),
          state: state,
          zip: _getShortNameFromComponent(details, 'postal_code'),
          city: city,
          searchString: '$streetNumber $streetShort, $city, $state',
          lat: detailsResponse.result.geometry!.location.lat,
          lng: detailsResponse.result.geometry!.location.lng,
        );
      },
      warningMessageForNotOkayResult: 'Could not get places from Google Maps',
    );
  }

  Future getPlacesAtCurrentLocation() async {
    var currentPosition;
    try {
      for (var trial in [
        Tuple2(LocationAccuracy.lowest, 2),
        Tuple2(LocationAccuracy.medium, 2),
        Tuple2(LocationAccuracy.high, 3)
      ]) {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: trial.item1,
          timeLimit: Duration(seconds: trial.item2),
        );
      }
    } catch (e) {
      return;
    }

    if (currentPosition == null) {
      return;
    }

    _currentPosition = PlacesLocation(
      id: '',
      placeName: '',
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    );

    return _runPlacesRequest<List<PlacesLocation>, PlacesSearchResponse>(
      placesRequest: _places!.searchNearbyWithRadius(
        Location(
          lat: _currentPosition.latitude!,
          lng: _currentPosition.longitude!,
        ),
        50,
      ),
      serialiseResponse: (searchResponse) {
        var results = searchResponse.results.map((result) => PlacesLocation(
              id: result.placeId,
              latitude: result.geometry!.location.lat,
              longitude: result.geometry!.location.lng,
              placeName: result.vicinity,
            ));
        return results.toList();
      },
      warningMessageForNotOkayResult: 'Could not get places from Google Maps',
    );
  }

  Future<RT> _runPlacesRequest<RT, AT>({
    required Future placesRequest,
    required RT Function(AT) serialiseResponse,
    required String warningMessageForNotOkayResult,
  }) async {
    try {
      var result = await placesRequest;
      if (result.isOkay) {
        return serialiseResponse(result);
      } else {
        throw PlacesApiException(message: warningMessageForNotOkayResult);
      }
    } catch (exception) {
      var errorMessage = 'A problem occurred making the places request.';
      throw PlacesApiException(message: errorMessage, exception: exception);
    }
  }

  String _getLongNameFromComponent(PlaceDetails details, String type) {
    try {
      return details.addressComponents
          .firstWhere((component) => component.types.contains(type))
          .longName;
    } catch (_) {
      return '';
    }
  }

  String _getShortNameFromComponent(PlaceDetails details, String type) {
    try {
      return details.addressComponents
          .firstWhere((component) => component.types.contains(type))
          .shortName;
    } catch (_) {
      return '';
    }
  }
}

/// Thrown from a PlacesApiService class and provides a detailed actionable message
/// for the developer to use in their code
class PlacesApiException implements Exception {
  final String message;
  final Object? exception;

  PlacesApiException({
    this.exception,
    required this.message,
  });

  @override
  String toString() {
    return '''PlacesApiException | $message
    exception | $exception''';
  }
}
