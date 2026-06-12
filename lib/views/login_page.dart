import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Color(0xFF220033)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      "Login",
                      style: TextStyle(color:Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.wrap_text, color: Colors.red),
                        labelText: "Username",
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
                    SizedBox(height: 20),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.wrap_text, color: Colors.red),
                        labelText: "Password",
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        // Full width, height: 50
                        backgroundColor: Colors.red,
                        // Change button color
                        foregroundColor: Colors.white, // Change text color
                      ),
                      onPressed: () =>{},
                      child: Text("Login"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/register');
                      },
                      child: const Text('Belum punya akun? Register',style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
