import 'package:app_berita_roni/config/api_service.dart';
import 'package:app_berita_roni/models/article_model.dart';
import 'package:app_berita_roni/views/articles/article_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/session.dart';


class ArticleDetailPage extends StatefulWidget {
  final DataArticle _dataArticle;

  const ArticleDetailPage(this._dataArticle, {super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Berita", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          if (widget._dataArticle.id == id) ...[
            IconButton(
              onPressed: () {
                context.push('/article-edit',extra: widget._dataArticle);
              },
              icon: Icon(Icons.edit, color: Colors.white),
            ),
            IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(height: 15),
              Center(
                child: Text(
                  widget._dataArticle.judul,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Image(
                image: NetworkImage(
                  "${ApiService.base_url}/${widget._dataArticle.gambar}",
                ),
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              Text(
                widget._dataArticle.createdAt,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.draw),
                  SizedBox(width: 10),
                  Text(widget._dataArticle.user),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget._dataArticle.isi),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
