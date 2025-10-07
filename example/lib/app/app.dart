import 'package:places_service/places_service.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/home/home_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    CupertinoRoute(page: HomeView, initial: true),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: PlacesService),
    // @stacked-service
  ],
  logger: StackedLogger(),
)
class App {}
