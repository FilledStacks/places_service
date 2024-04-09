import 'package:places_example/ui/home/home_view.dart';
import 'package:places_service/places_service.dart';
import 'package:stacked/stacked_annotations.dart';
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
