import 'package:app_berita_roni/views/users/user_profile.dart';
import 'package:go_router/go_router.dart';

class UserRoute {
  static List<RouteBase> routes = [
    GoRoute(path: '/profile', builder: (context, state) => UserProfile()),
  ];
}
