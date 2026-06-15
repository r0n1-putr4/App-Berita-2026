import 'package:app_berita_roni/config/api_service.dart';
import 'package:app_berita_roni/models/article_model.dart';
import 'package:app_berita_roni/providers/article_provider.dart';
import 'package:app_berita_roni/views/articles/article_edit_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/session.dart';

class ArticleDetailPage extends StatefulWidget {
  final DataArticle _dataArticle;

  const ArticleDetailPage(this._dataArticle, {super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  int? id;
  bool? is_admin;

  void _loadSession() async {
    Map<String, dynamic> session = await SessionManager.getSession();
    setState(() {
      id = session['id'];
      is_admin = session['is_admin'];
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
    final provider = context.watch<ArticleProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Berita", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Color(0xFF220033)],
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          if (widget._dataArticle.userId == id || is_admin!) ...[
            IconButton(
              onPressed: () {
                context.push('/article-edit', extra: widget._dataArticle);
              },
              icon: Icon(Icons.edit, color: Colors.white),
            ),
            IconButton(
              onPressed: provider.isLoading
                  ? null
                  : () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.scale,
                        title: 'Hapus Berita',
                        desc: 'Apakah Anda yakin ingin menghapus?',
                        btnCancelText: 'Batal',
                        btnOkText: 'Hapus',
                        btnCancelColor: Colors.blue,
                        btnCancelOnPress: () {},
                        btnOkColor: Colors.red,
                        btnOkOnPress: () async {
                          String pesan = await context
                              .read<ArticleProvider>()
                              .deleteArticle(widget._dataArticle.id);

                          if (context.mounted) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(pesan)));

                            if (provider.status) {
                              context.push('/');
                            }
                          }
                        },
                      ).show();
                    },
              icon: const Icon(Icons.delete, color: Colors.red),
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
