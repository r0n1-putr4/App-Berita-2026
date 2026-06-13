import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/api_service.dart';
import '../../config/session.dart';
import '../../models/article_model.dart';
import '../../providers/article_provider.dart';

class UserAticlePage extends StatefulWidget {
  const UserAticlePage({super.key});

  @override
  State<UserAticlePage> createState() => _UserAticlePageState();
}

class _UserAticlePageState extends State<UserAticlePage> {
  int? id;
  void _loadSession() async {
    Map<String, dynamic> session = await SessionManager.getSession();
    setState(() {
      id = session['id'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSession();
    Future.microtask(
      () => context.read<ArticleProvider>().getDataArticleUser(id!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
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
                      context.push('/article-detail', extra: dataArticle);
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  dataArticle.createdAt,
                                  style: TextStyle(fontSize: 9),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.draw,
                                      color: Colors.blue,
                                      size: 9,
                                    ),
                                    Text(
                                      dataArticle.user,
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    SizedBox(width: 5),
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
          context.push("/article-add");
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
