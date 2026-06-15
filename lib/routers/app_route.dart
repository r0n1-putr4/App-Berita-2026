import 'package:app_berita_roni/routers/article_route.dart';
import 'package:app_berita_roni/routers/auth_route.dart';
import 'package:app_berita_roni/routers/user_route.dart';
import 'package:app_berita_roni/views/home_page.dart';
import 'package:go_router/go_router.dart';

import '../config/session.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) async {
    final isLogin = await SessionManager.isLogin();

    final publicRoutes = ['/login', '/register'];

    if (!isLogin && !publicRoutes.contains(state.matchedLocation)) {
      return '/login';
    }

    if (isLogin &&
        (state.matchedLocation == '/login' ||
            state.matchedLocation == '/register')) {
      return '/';
    }

    return null;
  },

  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),

    ...ArticleRoute.routes,
    ...AuthRoutes.routes,
    ...UserRoute.routes,
  ],
);
