import 'package:app_berita_roni/views/articles/article_page.dart';
import 'package:app_berita_roni/views/users/user_aticle_page.dart';
import 'package:app_berita_roni/views/users/user_page.dart';
import 'package:flutter/material.dart';

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
    UserPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _halaman[_pilBottomNav]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _klikBottomNav,
        currentIndex: _pilBottomNav,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade500,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.draw), label: "My Article"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Penulis"),
        ],
      ),
    );
  }
}

