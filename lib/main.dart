import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/tamus_controller.dart';
import 'views/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TamusController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daftar Tamu',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: LoginView(), // Halaman login pertama kali ditampilkan
      ),
    );
  }
}
