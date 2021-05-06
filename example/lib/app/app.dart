import 'package:places_example/ui/home/home_view.dart';
import 'package:places_service/places_service.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: HomeView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: PlacesService),
  ],
  logger: StackedLogger(),
)
class App {}
