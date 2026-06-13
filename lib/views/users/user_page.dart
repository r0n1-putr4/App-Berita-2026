import 'package:app_berita_roni/config/api_service.dart';
import 'package:app_berita_roni/models/user_model.dart';
import 'package:app_berita_roni/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<UserProvider>().getDataUser());
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.dataUser.isEmpty
          ? Center(child: Text("Data Penulis Kosong"))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: provider.dataUser.length,
        itemBuilder: (context, index) {
          DataUser dataUser = provider.dataUser[index];
          return Container(
            padding: EdgeInsets.all(3),
            child: GestureDetector(
              onTap: () {
            
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image(
                            image: NetworkImage(
                              "${ApiService.base_url}/${dataUser.gambar}",
                            ),
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        dataUser.fullName,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text(
                        dataUser.email,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
