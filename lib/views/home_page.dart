import 'package:app_berita_roni/views/articles/article_page.dart';
import 'package:app_berita_roni/views/users/user_aticle_page.dart';
import 'package:app_berita_roni/views/users/user_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/session.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pilBottomNav = 0;

  void _klikBottomNav(int index) {
    setState(() {
      _pilBottomNav = index;
    });
  }

  static final List<Widget> _halaman = [
    ArticlePage(),
    UserAticlePage(),
    UserPage(),
  ];

  void logout() async {
    await SessionManager.clearSession();
    context.push('/login');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Portal Berita",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                headerAnimationLoop: false,
                animType: AnimType.bottomSlide,
                title: 'Logout',
                desc: 'Apakah anda yakin ingin keluar?',
                buttonsTextStyle: const TextStyle(color: Colors.white),
                showCloseIcon: true,
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  logout();
                },
              ).show();
            },
          ),
        ],
      ),
      body: Center(child: _halaman[_pilBottomNav]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _klikBottomNav,
        currentIndex: _pilBottomNav,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.draw), label: "My Article"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Penulis"),
        ],
      ),
    );
  }
}
