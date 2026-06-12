import 'package:app_berita_roni/views/login_page.dart';
import 'package:app_berita_roni/views/register_page.dart';
import 'package:go_router/go_router.dart';



class AuthRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) {
        return const RegisterPage();
      },
    ),
  ];
}