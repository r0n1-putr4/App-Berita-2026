import 'dart:io';

import 'package:app_berita_roni/config/api_service.dart';
import 'package:app_berita_roni/models/model_article.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ArticleDetailPage extends StatefulWidget {
  final DataArticle _dataArticle;

  const ArticleDetailPage(this._dataArticle, {super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Berita", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: Colors.white),
          ),
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
