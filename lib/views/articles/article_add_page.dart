import 'dart:io';

import 'package:app_berita_roni/providers/article_provider.dart';
import 'package:app_berita_roni/views/articles/article_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ArticleAddPage extends StatefulWidget {
  const ArticleAddPage({super.key});

  @override
  State<ArticleAddPage> createState() => _ArticleAddPageState();
}

class _ArticleAddPageState extends State<ArticleAddPage> {
  TextEditingController judul = TextEditingController();
  TextEditingController isiBerita = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _alertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Silahkan dipilih?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.camera);
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Camera"),
            ),
            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.gallery);
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Gallery"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Center(
                  child: Text(
                    "Tambah Article",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: judul,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.wrap_text, color: Colors.red),
                    labelText: "Judul Article",
                    filled: true,
                    fillColor: Colors.amber.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                ),
                SizedBox(height: 15),
                Text(
                  "Pilih Gambar",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    // Full width, height: 50
                    backgroundColor: Colors.red,
                    // Change button color
                    foregroundColor: Colors.white, // Change text color
                  ),
                  onPressed: () => _alertDialog(context),
                  child: Text("Pilih"),
                ),
                SizedBox(height: 5),
                _image != null
                    ? Center(child: Image.file(_image!, height: 200))
                    : Text("No image selected"),
                SizedBox(height: 15),
                Text(
                  "Isi Berita",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: isiBerita,
                  maxLines: 5, // Allows multiple lines
                  decoration: InputDecoration(
                    hintText: 'Enter your text here...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            if (_image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Pilih gambar terlebih dahulu"),
                                ),
                              );
                              return;
                            }

                            String pesan = await context
                                .read<ArticleProvider>()
                                .addArticle(
                                  1,
                                  judul.text,
                                  isiBerita.text,
                                  _image!,
                                );

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text("$pesan")));

                            if (provider.status) {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>ArticlePage()));
                            }
                          }
                        },
                  child: provider.isLoading
                      ? CircularProgressIndicator()
                      : Text("SAVE"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
