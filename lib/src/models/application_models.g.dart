// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlacesDetailsImpl _$$PlacesDetailsImplFromJson(Map<String, dynamic> json) =>
    _$PlacesDetailsImpl(
      placeId: json['placeId'] as String?,
      streetNumber: json['streetNumber'] as String?,
      streetShort: json['streetShort'] as String?,
      streetLong: json['streetLong'] as String?,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      city: json['city'] as String?,
      searchString: json['searchString'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PlacesDetailsImplToJson(_$PlacesDetailsImpl instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'streetNumber': instance.streetNumber,
      'streetShort': instance.streetShort,
      'streetLong': instance.streetLong,
      'state': instance.state,
      'zip': instance.zip,
      'city': instance.city,
      'searchString': instance.searchString,
      'lat': instance.lat,
      'lng': instance.lng,
    };

_$PlacesAutoCompleteResultImpl _$$PlacesAutoCompleteResultImplFromJson(
        Map<String, dynamic> json) =>
    _$PlacesAutoCompleteResultImpl(
      placeId: json['placeId'] as String?,
      mainText: json['mainText'] as String?,
      description: json['description'] as String?,
      secondaryText: json['secondaryText'] as String?,
    );

Map<String, dynamic> _$$PlacesAutoCompleteResultImplToJson(
        _$PlacesAutoCompleteResultImpl instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'mainText': instance.mainText,
      'description': instance.description,
      'secondaryText': instance.secondaryText,
    };

_$PlacesLocationImpl _$$PlacesLocationImplFromJson(Map<String, dynamic> json) =>
    _$PlacesLocationImpl(
      id: json['id'] as String,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      placeName: json['placeName'] as String?,
    );

Map<String, dynamic> _$$PlacesLocationImplToJson(
        _$PlacesLocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'placeName': instance.placeName,
    };
