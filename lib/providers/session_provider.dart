import 'package:flutter/material.dart';

import '../config/session.dart';

class SessionProvider extends ChangeNotifier {
  late String username;
  late String full_name ;
  late String email ;
  late String gambar;

  Future<void> loadSession() async {
    Map<String, dynamic> session = await SessionManager.getSession();

    username = session['username'] ;
    full_name = session['full_name'] ;
    email = session['email'] ;
    gambar = session['gambar'] ;

    notifyListeners();
  }
}