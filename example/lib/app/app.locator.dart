// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:places_service/places_service.dart';
import 'package:stacked/stacked.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => PlacesService());
}
