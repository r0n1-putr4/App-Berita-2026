import 'dart:developer';
import 'dart:io';

import 'package:app_berita_roni/config/api_service.dart';
import 'package:app_berita_roni/models/model_article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/model_response.dart';

class ProviderArticle extends ChangeNotifier {
  List<DataArticle> _dataArticle = [];
  List<DataArticle> get article => _dataArticle;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  int? _statusCode;
  int? get statusCode => _statusCode;

  Future<void> getIndex() async {
    try {
      _isLoading = true;
      notifyListeners();
      http.Response response = await http
          .get(Uri.parse("${ApiService.base_url}/articles"))
          .timeout(const Duration(seconds: 10));

      _statusCode = response.statusCode;
      final modelArticle = modelArticleFromJson(response.body);
      _dataArticle = modelArticle.dataArticles ?? [];
      _message = modelArticle.message;
    } catch (e) {
      _message = "Error : $e";
    } finally {
      _isLoading = false;
      _status = false;
      notifyListeners();
    }
  }

  Future<String> addArticle(int user_id,String judul, String isi, File image) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse("${ApiService.base_url}/articles");

      var request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = user_id.toString() ;
      request.fields['judul'] = judul;

      request.fields['isi'] = isi;

      request.files.add(
        await http.MultipartFile.fromPath('gambar', image.path),
      );

      http.StreamedResponse streamedResponse = await request.send();

      http.Response response = await http.Response.fromStream(streamedResponse);

      final hasil = modelResponseFromJson(response.body);

      _status = hasil.status;

      return hasil.message;
    } catch (e) {
      return _message = "Error : $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> editArticle(int id,int user_id,String judul, String isi,  File? image,) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse("${ApiService.base_url}/articles/$id");

      var request = http.MultipartRequest('POST', url);

      request.fields['user_id'] = user_id.toString() ;
      request.fields['judul'] = judul;

      request.fields['isi'] = isi;

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'gambar',
            image.path,
          ),
        );
      }

      http.StreamedResponse streamedResponse = await request.send();

      http.Response response = await http.Response.fromStream(streamedResponse);

      final hasil = modelResponseFromJson(response.body);

      _status = hasil.status;

      return hasil.message;
    } catch (e) {
      return _message = "Error : $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
