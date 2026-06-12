import 'package:app_berita_roni/models/model_article.dart';
import 'package:app_berita_roni/views/articles/article_edit_page.dart';
import 'package:app_berita_roni/views/articles/article_page.dart';
import 'package:app_berita_roni/views/home_view.dart';
import 'package:go_router/go_router.dart';

class ArticleRoute {
  static final List<RouteBase> routes = [
    GoRoute(path: '/', builder: (context, state) => const ArticlePage()),
    GoRoute(
      path: '/article-edit',
      builder: (context, state) => ArticleEditPage(state.extra as DataArticle),
    ),
  ];
}
