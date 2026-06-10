import 'package:app_berita_roni/config/api_service.dart';
import 'package:app_berita_roni/models/model_article.dart';
import 'package:app_berita_roni/providers/provider_article.dart';
import 'package:app_berita_roni/views/articles/article_add_page.dart';
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
    final provider = Provider.of<ProviderArticle>(context);
    return Scaffold(
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.statusCode != 200
          ? Center(child: Text("Tidak terhubung ke API"))
          : provider.article.isEmpty
          ? Center(child: Text("Data Article Kosong"))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: provider.article.length,
                itemBuilder: (context, index) {
                  DataArticle dataArticle = provider.article[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => DetailListPage(itemBerita),
                      //   ),
                      // );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(
                                  "${ApiService.base_url}/${dataArticle.gambar}",
                                ),
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataArticle.judul,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  dataArticle.createdAt,
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.draw,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                    Text(
                                      dataArticle.user,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ArticleAddPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
