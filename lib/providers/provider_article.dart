import 'dart:developer';

import 'package:app_berita_roni/config/api_service.dart';
import 'package:app_berita_roni/models/model_article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderArticle extends ChangeNotifier {
  List<DataArticle> _dataArticle = [];
  List<DataArticle> get article => _dataArticle;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<void> getIndex() async{
    try{

      _isLoading = true;
      notifyListeners();
      http.Response _response = await http.get(Uri.parse("${ApiService.base_url}/articles"));
      final _modelArticle = modelArticleFromJson(_response.body);
      _dataArticle = _modelArticle.dataArticles ?? [];
      _message = _modelArticle.message;
    }catch(e){
      _message = "Error : $e";
    }finally{
      _isLoading = false;
      _status = false;
      notifyListeners();
    }
  }
}