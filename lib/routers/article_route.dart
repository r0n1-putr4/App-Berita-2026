import 'package:app_berita_roni/models/model_article.dart';
import 'package:app_berita_roni/views/articles/article_add_page.dart';
import 'package:app_berita_roni/views/articles/article_detail_page.dart';
import 'package:app_berita_roni/views/articles/article_edit_page.dart';
import 'package:app_berita_roni/views/articles/article_page.dart';
import 'package:go_router/go_router.dart';

class ArticleRoute {
  static final List<RouteBase> routes = [
    GoRoute(path: '/', builder: (context, state) => const ArticlePage()),
    GoRoute(
      path: '/article-edit',
      builder: (context, state) => ArticleEditPage(state.extra as DataArticle),
    ),
    GoRoute(
      path: '/article-detail',
      builder: (context, state) => ArticleDetailPage(state.extra as DataArticle),
    ),
    GoRoute(path: '/article-add',builder: (context,state)=>ArticleAddPage())
  ];
}
