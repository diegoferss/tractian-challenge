import 'package:tractian/features/home/home_view.dart';

class MobileRouter {
  static const String initialRoute = '/home';

  static final routes = {
    '/home': (_) => const HomeView(),
  };
}
