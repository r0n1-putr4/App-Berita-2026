import 'package:app_berita_roni/providers/provider_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<ProviderArticle>().getIndex());
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProviderArticle>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("List Article"),
      ),
      body: _provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : _provider.article.isEmpty
          ? Center(child: Text("Data Article Kosong"))
          : Center(child: Text(_provider.message)),
    );
  }
}
