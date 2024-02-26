import 'package:get/route_manager.dart';
import 'package:remona/routes/pages.dart';
import '../bindings/home_binding.dart';
import '../home/home_view.dart';

class Pages {
  static final routes = [
    GetPage(name: Routes.home, page: () => HomeView(), bindings: [
      HomeBinding(),
    ]),
  ];
}
