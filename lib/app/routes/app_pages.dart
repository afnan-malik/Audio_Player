import 'package:get/get.dart';
import 'package:untitled1/player/bindings/player_binding.dart';
import 'package:untitled1/player/views/player_view.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),  GetPage(
      name: _Paths.PLAYER,
      page: () => const PlayerView(),
      binding: PlayerBinding(),
    ),
  ];
}
