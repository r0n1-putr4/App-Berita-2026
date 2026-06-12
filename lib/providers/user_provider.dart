import 'package:app_berita_roni/config/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/login_model.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _message = "";

  String get message => _message;

  bool _status = false;

  bool get status => _status;

  Data? _user;

  Data? get user => _user;

  Future<String> login(String username, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      http.Response hasil = await http.post(
        Uri.parse("${ApiService.base_url}/users/login"),
        body: {"username": username, "password": password},
      );
      final loginModel = loginModelFromJson(hasil.body);
      _status = loginModel.status;
      _message = loginModel.message;

      if (loginModel.data != null) {
        _user = loginModel.data;
      }

      return _message;
    } catch (e) {
      _message = "Error : $e";
      return _message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
